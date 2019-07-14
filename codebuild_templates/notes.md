```bash
aws codebuild list-projects
aws codebuild start-build --project-name ansible-test

aws codebuild update-project --name cfn-network --generate-cli-skeleton > create-project.json
aws codebuild update-project --name cfn-network > output-project.json

aws codebuild create-project --cli-input-json file://codebuild_templates/cfn-network.json
aws codebuild create-project --cli-input-json file://codebuild_templates/cfn-compute.json
```