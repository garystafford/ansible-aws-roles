#!/usr/bin/env bash

# Write Ansible demo parameters to Parameter Store

# Change KEY_PATH value to match you environment!
KEY_PATH="/Users/garystafford/.ssh/ansible"
PARAMETER_PATH="/ansible_demo"

# Put parameters
aws ssm put-parameter \
  --name $PARAMETER_PATH/ansible_private_key \
  --type SecureString \
  --value "file://${KEY_PATH}" \
  --description "Ansible private key for EC2 instances" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/ssh_location \
  --type String \
  --value "0.0.0.0/0" \
  --description "IP Address Range from which SSH is allowed" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/instance_type \
  --type String \
  --value "t2.small" \
  --description "Instance type of Web Servers" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/key_name \
  --type String \
  --value "ansible" \
  --description "SSH key name" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/vpc_cidr \
  --type String \
  --value "10.0.0.0/24" \
  --description "VPC CIDR" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/public_subnet_1_cidr \
  --type String \
  --value "10.0.0.0/28" \
  --description "Public subnet in the first AZ" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/public_subnet_2_cidr \
  --type String \
  --value "10.0.0.16/28" \
  --description "Public subnet in the second AZ" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/private_subnet_1_cidr \
  --type String \
  --value "10.0.0.32/28" \
  --description "Private subnet in the first AZ" \
  --overwrite

aws ssm put-parameter \
  --name $PARAMETER_PATH/private_subnet_2_cidr \
  --type String \
  --value "10.0.0.48/28" \
  --description "Private subnet in the second AZ" \
  --overwrite

# Spot check parameters
aws ssm get-parameter \
  --with-decryption \
  --name $PARAMETER_PATH/ansible_private_key \
  --query Parameter.Value

aws ssm get-parameter \
  --name $PARAMETER_PATH/instance_type \
  --query Parameter.Value
