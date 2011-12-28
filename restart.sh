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

echo "*) Stopping JBossAS (directory '$JBOSS_HOME')..."
$JBOSS_HOME/stop.sh
sleep 2
$JBOSS_HOME/start.sh

