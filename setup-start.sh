#! /usr/bin/env bash

DAEMONS="mysqld \
cloudera-quickstart-init \
zookeeper-server \
hadoop-hdfs-datanode \
hadoop-hdfs-journalnode \
hadoop-hdfs-namenode \
hadoop-yarn-nodemanager \
hadoop-yarn-resourcemanager \
hadoop-mapreduce-historyserver \
hive-metastore \
hive-server2 \
spark-history-server"

for daemon in ${DAEMONS}; do
    sudo service ${daemon} start
done

/opt/zeppelin/bin/zeppelin-daemon.sh start

exec bash