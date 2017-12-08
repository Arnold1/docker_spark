#!/bin/bash

: ${HADOOP_PREFIX:=/usr/local/hadoop}

$HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

rm /tmp/*.pid

# installing libraries if any - (resource urls added comma separated to the ACP system variable)
cd $HADOOP_PREFIX/share/hadoop/common ; for cp in ${ACP//,/ }; do  echo == $cp; curl -LO $cp ; done; cd -

# altering the core-site configuration
sed s/HOSTNAME/$HOSTNAME/ /usr/local/hadoop/etc/hadoop/core-site.xml.template > /usr/local/hadoop/etc/hadoop/core-site.xml

#cat <<EOF > /usr/local/hadoop/etc/hadoop/hdfs-site.xml
#<configuration>
#    <property>
#        <name>dfs.replication</name>
#        <value>1</value>
#    </property>
#    <property>
#        <name>dfs.safemode.threshold.pct</name>
#        <value>0</value>
#    </property>
#</configuration>
#EOF

#cat <<EOF > /usr/local/spark/conf/metrics.properties
#*.sink.jmx.class=org.apache.spark.metrics.sink.JmxSink
#EOF

service sshd start
$HADOOP_PREFIX/sbin/start-dfs.sh
$HADOOP_PREFIX/sbin/start-yarn.sh
$HADOOP_PREFIX/sbin/mr-jobhistory-daemon.sh start historyserver

# executes $1 as a shell script or stops sshd if $1 is -d.
CMD=${1:-"exit 0"}
if [[ "$CMD" == "-d" ]];
then
  service sshd stop
  /usr/sbin/sshd -D -d
else
  /bin/bash -c "$*"
fi