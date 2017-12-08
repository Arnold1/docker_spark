#!/bin/bash

docker build --rm -t sequenceiq/spark:2.1.0 .
docker run -it -p 8088:8088 -p 8042:8042 -p 4040:4040 -h sandbox sequenceiq/spark:2.1.0 /startup.sh #bash
