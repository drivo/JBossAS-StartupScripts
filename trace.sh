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

echo "Taking a trace of JBossAS java process..."

JBOSS_TRACE_FILE="jboss_trace_`hostname`_`date +%Y%m%d_%H%M`.txt"

if [ $JBOSS_PID ]
then
	echo " - JBossAS process id: "${JBOSS_PID}
	echo " - Trace file: "${JBOSS_TRACE_FILE}
	echo " - Starting dumping (don't worry about the exceptions, if any)..."

################################	

	echo "" > ${JBOSS_TRACE_FILE}
	echo "== JMAP - HEAP =========================================================" >> ${JBOSS_TRACE_FILE}
	echo "" >> ${JBOSS_TRACE_FILE}
	
	jmap -heap $JBOSS_PID >> ${JBOSS_TRACE_FILE}

################################	

	echo "" >> ${JBOSS_TRACE_FILE}
	echo "== JSTACK ==============================================================" >> ${JBOSS_TRACE_FILE}
	echo "" >> ${JBOSS_TRACE_FILE}
	
	jstack -F $JBOSS_PID >> ${JBOSS_TRACE_FILE}
	
################################
	
	echo "" >> ${JBOSS_TRACE_FILE}
	echo "== JMAP - OBJECT HEAP HISTOGRAM ========================================" >> ${JBOSS_TRACE_FILE}
	echo "" >> ${JBOSS_TRACE_FILE}
	
	jmap -histo $JBOSS_PID >> ${JBOSS_TRACE_FILE}

################################à

	echo " - Starting dumping...done"
	echo " - The trace '${JBOSS_TRACE_FILE}' is ready for further analysis."
else
	echo "Ops, JBossAS process is not up and running!"
fi

