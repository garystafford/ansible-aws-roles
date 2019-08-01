https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#inventory-script-example-aws-ec2
https://docs.ansible.com/ansible/latest/plugins/inventory.html

https://gist.github.com/ruzickap/3f795259af505ff06023b15a29ac817a

```bash
aws cloudformation validate-template --template-body file://ansible_cf_demo.json
aws s3 cp ansible_cf_demo.json s3://garystafford_cloud_formation/cf_demo/

sudo cp ec2.* /etc/ansible
chmod +x ec2.py
chmod +x ec2.ini

ansible -i inventories/ec2.py -u ec2-user us-east-1 -m ping
ansible us-east-1 \
  --inventory inventories/ec2.py \
  --user ec2-user \
  --private-key ~/.ssh/my-aws-account-keypair.pem \
  --module-name ping
ansible-inventory -i inventories/aws_ec2.yml --graph
ansible-inventory --list -i inventories/aws_ec2.yml --yaml


ansible-playbook \
  -i inventories/aws_ec2.yml \
  playbooks/10_webserver_config.yml --check

ansible-playbook \
  --inventory inventories/aws_ec2.yml \
  site.yml --tags create \
  --check

ansible-playbook \
  -i inventories/aws_ec2.yml \
  site.yml -t delete

ansible-playbook \
  --inventory inventories/aws_ec2.yml \
  playbooks/10_cf_config.yml --tags delete

aws cloudformation delete-stack --stack-name ansible-cf-demo

# tag_Group_webservers

./inventories/ec2.py --refresh-cache

# Parameters Store
aws ssm get-parameter \
  --with-decryption \
  --name "/ansible_demo/ansible_private_key" \
  --query Parameter.Value

aws ssm put-parameter \
  --name /ansible_demo/ansible_private_key \
  --type SecureString \
  --value file:///Users/garystafford/.ssh/ansible \
  --description "Private key for EC2 instances" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/ssh_location \
  --type String \
  --value "0.0.0.0/0" \
  --description "IP Address (Range) from which SSH is allowed" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/instance_type \
  --type String \
  --value "t2.small" \
  --description "Instance type of Web Servers" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/key_name \
  --type String \
  --value "ansible" \
  --description "SSH key name" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/vpc_cidr \
  --type String \
  --value "10.0.0.0/24" \
  --description "VPC CIDR" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/public_subnet_1_cidr \
  --type String \
  --value "10.0.0.0/28" \
  --description "Public subnet in the first AZ" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/public_subnet_2_cidr \
  --type String \
  --value "10.0.0.16/28" \
  --description "Public subnet in the second AZ" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/private_subnet_1_cidr \
  --type String \
  --value "10.0.0.32/28" \
  --description "Private subnet in the first AZ" \
  --overwrite

aws ssm put-parameter \
  --name /ansible_demo/private_subnet_2_cidr \
  --type String \
  --value "10.0.0.48/28" \
  --description "Private subnet in the second AZ" \
  --overwrite

aws codebuild list-projects
aws codebuild start-build --project-name cfn-validate-s3
aws codebuild start-build --project-name cfn-network
aws codebuild start-build --project-name cfn-compute
aws codebuild start-build --project-name ansible-web-config
aws codebuild start-build --project-name ansible-test

time ansible-playbook \
  -i inventories/aws_ec2.yml \
  playbooks/20_cfn_compute.yml -t delete -v

time ansible-playbook \
  -i inventories/aws_ec2.yml \
  playbooks/10_cfn_network.yml -t delete -v

```
