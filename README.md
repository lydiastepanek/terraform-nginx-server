# Setup

Steps:
* Install terraform: `brew install terraform`
* Download your aws ec2 key pair and update `aws_user_key_path` and `key_name` variable in
  `staging/variables.tf`
* Configure an aws profile called `home`: `aws configure --profile=home`
* Remove `terraform.tf` file and initialize terraform backend resources:
```
terraform init
terraform apply -target aws_dynamodb_table.dynamodb-terraform-state-lock -target aws_s3_bucket.terraform-nginx-state-storage
```
* Add back `terraform.tf` file now that backend resources have been created
* Recreate terraform state:
```
rm -rf .terraform
terraform init
terraform apply
```

# Run ansible
* Update the IP addresses for the app server and bastion in `ansible/hosts` and
  `ansible/group_vars/app.yml` files
* Run ansible:
```
ansible-playbook ansible/playbook.yml
```
