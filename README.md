# cloudera-spark
Docker image for a Cloudera Quickstart cluster with upgraded (and functional) Spark/Java/Zeppelin

Cloudera QuickStart image is a single-node deployment of Cloudera's 100% open-source distribution including Apache Hadoop, and Cloudera Manager. 
This is an ideal environment for learning about Spark on Hadoop, trying out new ideas, testing and demoing your Spark application.

This is completely based on the Cloudera's Quickstart for more info go to the [Cloudera's dockerhub](https://hub.docker.com/r/cloudera/quickstart).

As opposed to the Cloudera Quickstart ([CDH 5.7.0](https://docs.cloudera.com/documentation/enterprise/release-notes/topics/cdh_vd_cdh_package_tarball_57.html#concept_0vc_ddn_yk)), this image has upgraded and preconfigured the following:
* Java 1.8.0-opendjk
* Spark 2.4.4
* Zeppelin 0.8.1

First you will want to import the image:
```
docker pull betoca/cloudera-spark
```

Once downloaded you can run as follows:
```
docker run --hostname=quickstart.cloudera --privileged=true -ti -p 8080:8080 betoca/cloudera-spark
``` 

By default `/usr/bin/setup-start.sh` is provided as a convenience to start **some basic** CDH services, then run a Bash shell. 
This is particularly convenient if you want to leverage HDFS/Hive for your Spark application
But also, you can directly run `/bin/bash` instead if you wish to start services manually.

