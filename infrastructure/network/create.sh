#! /bin/bash

aws cloudformation create-stack \
--stack-name 'UdacityCapstoneProject-Network' \
--template-body file://network.yml  \
--parameters file://parameters.json \
--region=us-west-2