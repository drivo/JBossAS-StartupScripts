#!/bin/bash

# Copyright 2011 (C) by Guido D'Albore (guido@bitstorm.it)
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

######################################################################
# Import configuration from 'server.conf'
SERVER_CONF_HOME=$(cd ${0%/*} && pwd -P)
source ${SERVER_CONF_HOME}/server.conf
######################################################################
# Drops system caches 
sync; sysctl -w vm.drop_caches=3 > /dev/null 2>&1
######################################################################

if [ $JBOSS_PID ]
then
	echo "Ops, you cannot start JBossAS twice. JBossAS process (pid=${JBOSS_PID}) is already up and running !"
else
	echo "*) JBOSS_HOME=$JBOSS_HOME"
	echo "*) Rising file descriptors to 32000"
	ulimit -HSn 32000
	
	echo "*) Deleting '${JBOSS_SERVER_CONFIGURATION_HOME}/work' directory..."
	rm -rf ${JBOSS_SERVER_CONFIGURATION_HOME}/work
	echo "*) Deleting '${JBOSS_SERVER_CONFIGURATION_HOME}/work' directory...done"
	
	echo "*) Deleting '${JBOSS_SERVER_CONFIGURATION_HOME}/tmp' directory..."
	rm -rf ${JBOSS_SERVER_CONFIGURATION_HOME}/tmp
	echo "*) Deleting '${JBOSS_SERVER_CONFIGURATION_HOME}/tmp' directory...done"
	echo "*) Deleting '${JBOSS_SERVER_CONFIGURATION_HOME}/data' directory..."
	rm -rf ${JBOSS_SERVER_CONFIGURATION_HOME}/data
	echo "*) Deleting '${JBOSS_SERVER_CONFIGURATION_HOME}/data' directory...done"
	echo "*) Starting JBossAS (Binding on ${JBOSS_IP_ADDRESS})..."
	export JAVA_OPTS="-Xms${JVM_HEAP_SIZE} \
                      -Xmx${JVM_HEAP_SIZE} \
                      -XX:PermSize=${JVM_PERM_SIZE} \
                      -XX:MaxPermSize=${JVM_PERM_SIZE} \
                      -XX:+PrintGCDetails \
                      -XX:-UseGCOverheadLimit \
                      -XX:+HeapDumpOnOutOfMemoryError \
                      -XX:HeapDumpPath=${JBOSS_LOG_HOME} \
                      -Xloggc:${JBOSS_LOG_HOME}/javagc.log \
                      -Dsun.rmi.dgc.client.gcInterval=3600000 \
                      -Djboss.service.binding.set=$JBOSS_PORT_CONFIGURATION \
                      ${JBOSS_ADDITIONAL_SYSTEM_PROPERTIES}"

    if [ "x${JBOSS_CLUSTER_NAME}" == "x" ] 
    then
        # Non clustered configuration
        /usr/bin/nohup ${JBOSS_HOME}/bin/run.sh -b ${JBOSS_IP_ADDRESS} -c $JBOSS_SERVER_CONFIGURATION > /dev/null 2>&1  &
    else
        # Clustered configuration
    	/usr/bin/nohup ${JBOSS_HOME}/bin/run.sh -b ${JBOSS_IP_ADDRESS} -c $JBOSS_SERVER_CONFIGURATION -u ${JBOSS_CLUSTER_UDP_ADDRESS} -g ${JBOSS_CLUSTER_NAME} > /dev/null 2>&1  &
    fi

	# Check whether JBossAS has successfully started...
	sleep 4
	JBOSS_NEW_PID=`pgrep -lf java | grep $JBOSS_SERVER_CONFIGURATION | grep $JBOSS_IP_ADDRESS | grep $JBOSS_PORT_CONFIGURATION |cut -d' ' -f1`
	
	if [ $JBOSS_NEW_PID ]
	then
		echo "JBossAS started successfully. New PID is $JBOSS_NEW_PID."
	else
		echo "JBossAS cannot start! The process hasn't been found."
	fi
fi

