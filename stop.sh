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

if [ $JBOSS_PID ]
then
	echo "Killing JBossAS with PID="${JBOSS_PID}...
	kill -9 $JBOSS_PID
	echo "Killing JBossAS with PID="${JBOSS_PID}"...done"
else
	echo "Ops, JBossAS process for current configuration is not up and running!"
fi


