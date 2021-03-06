FROM cloudera/quickstart

# Install wget and java 8
RUN yum -y install wget java-1.8.0-openjdk ; yum clean all

#Python 3.6
RUN yum -y install centos-release-scl
RUN yum -y install rh-python36
RUN ln -fs /opt/rh/rh-python36/root/usr/bin/python /usr/bin/python

#Upgrade to Spark 2
WORKDIR /opt

RUN wget https://archive.apache.org/dist/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.6.tgz
RUN tar xf spark-2.4.4-bin-hadoop2.6.tgz
RUN mv spark-2.4.4-bin-hadoop2.6 spark
RUN mv /usr/lib/spark/ /tmp/spark
RUN ln -s /opt/spark /usr/lib/spark
RUN cp /tmp/spark/conf/spark-env.sh /opt/spark/conf/
RUN cp /opt/spark/conf/log4j.properties.template /opt/spark/conf/log4j.properties
RUN sed -i 's/\/etc\/hadoop\/conf\}/\/etc\/hadoop\/conf\}:\/etc\/hadoop\/conf:\/etc\/hive\/conf/g' /opt/spark/conf/spark-env.sh
RUN sed -i '1i export JAVA_HOME=\/usr\/lib\/jvm\/jre-1.8.0-openjdk.x86_64' /usr/lib/bigtop-utils/bigtop-detect-javahome
RUN sed -i 's/rootCategory\=INFO/rootCategory\=WARN/g' /opt/spark/conf/log4j.properties
RUN sed -i 's/lib\/spark-assembly-\*.jar/jars\/spark-hive\*jar/g' /usr/lib/hive/bin/hive
RUN cp /usr/bin/spark-shell /usr/bin/spark-sql
RUN sed -i 's/spark-shell/spark-sql/g' /usr/bin/spark-sql

# Enable historyserver logs
RUN sed -i 's/0.0.0.0:10020/quickstart.cloudera:10020/g' /etc/hadoop/conf/mapred-site.xml
RUN sed -i 's/0.0.0.0:19888/quickstart.cloudera:19888/g' /etc/hadoop/conf/mapred-site.xml
RUN sed -i 's/<\/configuration>/<property><name>yarn.log.server.url<\/name><value>http:\/\/quickstart.cloudera:19888\/jobhistory\/logs<\/value><\/property><\/configuration>/g' /etc/hadoop/conf/yarn-site.xml

# Install Zeppelin
RUN wget https://downloads.apache.org/zeppelin/zeppelin-0.8.2/zeppelin-0.8.2-bin-all.tgz
RUN sudo tar xf zeppelin-*-bin-all.tgz -C /opt
RUN sudo mv /opt/zeppelin-*-bin-all /opt/zeppelin
RUN cp /opt/zeppelin/conf/zeppelin-env.sh.template /opt/zeppelin/conf/zeppelin-env.sh
RUN sed -i '1i export MASTER=local\[\*\]' /opt/zeppelin/conf/zeppelin-env.sh
RUN sed -i '1i export HADOOP_CONF_DIR=\/etc\/hadoop\/conf' /opt/zeppelin/conf/zeppelin-env.sh
RUN sed -i '1i export SPARK_HOME=\/opt\/spark' /opt/zeppelin/conf/zeppelin-env.sh
RUN sed -i '1i export ZEPPELIN_SPARK_MAXRESULT=3000' /opt/zeppelin/conf/zeppelin-env.sh

ADD setup-start.sh /usr/bin/

WORKDIR /home/cloudera

EXPOSE 8080
EXPOSE 4040

CMD ["/usr/bin/setup-start.sh"]
