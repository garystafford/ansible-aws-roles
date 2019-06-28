https://docs.ansible.com/ansible/latest/user_guide/intro_dynamic_inventory.html#inventory-script-example-aws-ec2
https://docs.ansible.com/ansible/latest/plugins/inventory.html

https://gist.github.com/ruzickap/3f795259af505ff06023b15a29ac817a

```bash
aws cloudformation validate-template --template-body file://ansible_cf_demo.json
aws s3 cp ansible_cf_demo.json s3://gaystafford_cloud_formation/cf_demo/

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
```
