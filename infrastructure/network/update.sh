#! /bin/bash

aws cloudformation update-stack \
--stack-name 'UdacityCapstoneProject-Network' \
--template-body file://network.yml  \
--parameters file://parameters.json \
--region=us-west-2