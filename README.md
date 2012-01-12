JBossAS 4.x, 5.x, 6.x Startup Scripts
=====================================

* Scripts for running and managing multiple and clustered JBossAS instances on the same server.
* Unique configuraton file for JBossAS instance
* Stop, Start, Restart scripts you can easily integrate into the system init procedure
* Scripts for tracing automatically JVM status (jps/jstack)
* JBOSS_HOME and server configuration auto-discovering

Installation
------------
Let's suppose we have four JBossAS instances:

* JBoss node 1 in "/usr/local/jboss-node1"
* JBoss node 2 in "/usr/local/jboss-node2"
* JBoss node 3 in "/usr/local/jboss-node3"
* JBoss node 4 in "/usr/local/jboss-node4"

then you need to copy all *.sh scripts (`start.sh`, `stop.sh`, `restart.sh`, `trace.sh` and `emergency.sh`) and `server.conf` in

* /usr/local/jboss-node1
* /usr/local/jboss-node2
* /usr/local/jboss-node3
* /usr/local/jboss-node4

Configuration
-------------
Let's suppose we have four JBossAS instances and we need to setup JBossAS on the same network interface with different binding ports:

* JBoss node 1 in "/usr/local/jboss-node1"
* JBoss node 2 in "/usr/local/jboss-node2"
* JBoss node 3 in "/usr/local/jboss-node3"
* JBoss node 4 in "/usr/local/jboss-node4"

then you need to:

* Open "/usr/local/jboss-node2/server.conf" and change the line

        JBOSS_PORT_CONFIGURATION=ports-default

    *with*


        JBOSS_PORT_CONFIGURATION=ports-01


* Open "/usr/local/jboss-node3/server.conf" and change the line

        JBOSS_PORT_CONFIGURATION=ports-default 

    *with*

        JBOSS_PORT_CONFIGURATION=ports-02

* Open "/usr/local/jboss-node4/server.conf" and change the line

        JBOSS_PORT_CONFIGURATION=ports-default 

    *with*

        JBOSS_PORT_CONFIGURATION=ports-03

You can do the same with other startup option you can find into server.conf file.

Usage
-----
All the scripts files depend on:

* Location where the scripts are copied (e.g. `/usr/local/jboss`)
* Content of server.conf which needs to be different between JBossAS nodes.

Each script, based on the script location and server.conf, can easily control its own JBossAS instance without
enter in conflict with other active JBossAS instances on the same server.

Starting JBossAS
----------------
Let's suppose we have four JBossAS instances:

* JBoss node 1 in "/usr/local/jboss-node1"
* JBoss node 2 in "/usr/local/jboss-node2"
* JBoss node 3 in "/usr/local/jboss-node3"
* JBoss node 4 in "/usr/local/jboss-node4"

        /usr/local/jboss-node1/start.sh

        /usr/local/jboss-node2/start.sh

        /usr/local/jboss-node3/start.sh

        /usr/local/jboss-node4/start.sh

Stopping JBossAS
----------------
Let's suppose we have four JBossAS instances:

* JBoss node 1 in "/usr/local/jboss-node1"
* JBoss node 2 in "/usr/local/jboss-node2"
* JBoss node 3 in "/usr/local/jboss-node3"
* JBoss node 4 in "/usr/local/jboss-node4"

        /usr/local/jboss-node1/stop.sh

        /usr/local/jboss-node2/stop.sh
        
        /usr/local/jboss-node3/stop.sh

        /usr/local/jboss-node4/stop.sh

Restarting JBossAS
------------------
Let's suppose we have four JBossAS instances:

* JBoss node 1 in "/usr/local/jboss-node1"
* JBoss node 2 in "/usr/local/jboss-node2"
* JBoss node 3 in "/usr/local/jboss-node3"
* JBoss node 4 in "/usr/local/jboss-node4"

        /usr/local/jboss-node1/restart.sh

        /usr/local/jboss-node2/restart.sh

        /usr/local/jboss-node3/restart.sh

        /usr/local/jboss-node4/restart.sh

License
-------
Copyright (C) 2012 by Guido D'Albore. [Licensed under the Apache License, Version 2.0](http://www.apache.org/licenses/LICENSE-2.0.txt)

