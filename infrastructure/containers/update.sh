#! /bin/bash

aws cloudformation update-stack \
--stack-name 'UdacityCapstoneProject-Containers' \
--template-body file://containers.yml  \
--parameters file://parameters.json \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-west-2