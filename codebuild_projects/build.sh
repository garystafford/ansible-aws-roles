#!/usr/bin/env bash

set -e

for template in ./*.json; do
    aws codebuild create-project --cli-input-json file://${template}
done
