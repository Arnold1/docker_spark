#!/bin/bash

spark-submit --class org.apache.spark.examples.SparkPi \
             --master yarn \
             --deploy-mode client \
             --driver-memory 1g \
             --executor-memory 1g \
             --executor-cores 1 \
             $SPARK_HOME/examples/jars/spark-examples*.jar
