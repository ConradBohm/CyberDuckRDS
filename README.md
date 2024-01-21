# CyberDuckRDS

This is a terraform repo that configures a MySQL database on Amazon AWS. This repo also configures a VPC, a couple of subnets, a KMS encryption key, and has a deployment pipeline based in GitHub actions.

## RDS
The RDS instance configuration can be found in the `rds.tf` file. It contains an RDS resource with appropriate configuration to suit the brief. The `skip_final_snapshot = true` option is so I can easily delete the resources once I've finished with this tech test. The file also contains code for a replica RDS instance that I tried to enable for high-availability, however I didn't manage to get it configured in the time set as it proved more fiddly than I'd anticipated.

A database acces user group has been created, but this was configured in console so does not reflect in this repository. Has I more time, I would have configured this as a new resource within this repo.

## VPC
The VPC config was just a basic set up across two avalability zones so that I could set up the multi-zone RDS instance. The security group config is very simple also, but would be more complex if the EC2 cluster were also configured.

## KMS
A key used to encrypt the data in the RDS database.

## GitHub Actions Pipeline
Here is where the terraform code is tested and applied. Terraform Validate makes sure that my code is syntactically correct, Plan shows me what my new terraform code will do, and Apply makes those changes laid out in the Plan step.

The terraform commands are run in a Terraform Cloud workspace, which is accessed via the API key stored as a secret in the GitHub repository's secrets. The terraform workspace then has access to the AWS credentials needed to make changes to the account. To replicate the code changes, those account settings need to be configured.

## Links & Resources
- https://spacelift.io/blog/terraform-aws-rds
- https://developer.hashicorp.com/terraform/tutorials/cloud-get-started
- https://aws.amazon.com/rds/instance-types/
