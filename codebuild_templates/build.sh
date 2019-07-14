#!/usr/bin/env bash

#set -ex

for template in codebuild_templates/*.json
do
    aws codebuild create-project --cli-input-json file://${template}
done