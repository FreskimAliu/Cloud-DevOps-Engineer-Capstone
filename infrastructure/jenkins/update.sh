#! /bin/bash

aws cloudformation update-stack \
--stack-name 'JenkinsInstances' \
--template-body file://instances.yml  \
--parameters file://parameters.json \
--capabilities "CAPABILITY_IAM" "CAPABILITY_NAMED_IAM" \
--region=us-west-2