#!/usr/bin/env bash

#set -ex

for template in ./*.json
do
    aws codebuild create-project --cli-input-json file://${template}
done