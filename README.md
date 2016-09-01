# infrastructure/sysops

Peg.ski runs on AWS.

The AWS infrastructure is maintained by Terraform. Services are being deployed using ansible.

## required

To be able to setup and provision the peg.ski infrastructure you need to have installed:

*   terraform (> 0.7)
*   ansible (>2.1)

For creating maps of the terraformed infrastructure you will need:
*   Graphviz (>)

besides that you will need AWS AIM account credentials and the deploy user private key. 

## secrets
You will need to provide AWS credentials as environment variables in order to be able to run the scripts.

These variables can be added to env/environment.local (for all linux versions) or environment.osx for OS X. 
 The following command can be used to load the environment in your current working shell:
 
  ```
  cd env; source ./loadenv.sh; cd -
  ```

Additionally, you will need the ssh public and private key of the deploy user for terraform. These should be placed in terraform/ssh.

## terraform state
The statefile for terraform is saved in a dedicated S3 bucket.
For this S3 bucket we applied the following S3 policy:
```
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Sid": "statement1",
         "Effect": "Allow",
         "Principal": {
            "AWS": "arn:aws:iam::<insert-arn-number>:user/terraform-bot-account"
         },
         "Action": [
            "s3:GetBucketLocation",
            "s3:ListBucket"
         ],
         "Resource": [
            "arn:aws:s3:::pegski-tfstate"
         ]
      },
      {
         "Sid": "statement2",
         "Effect": "Allow",
         "Principal": {
            "AWS": "arn:aws:iam::<insert-arn-number>:user/terraform-bot-account"
         },
         "Action": [
             "s3:GetObject"
         ],
         "Resource": [
            "arn:aws:s3:::pegski-tfstate/*"
         ]
      }
   ]
}
```

and the inline policy for the aim user terraform-bot-account
```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PermissionForObjectOperations",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject"
            ],
            "Resource": [
                "arn:aws:s3:::pegski-tfstate/*"
            ]
        }
    ]
}
```


## deploy the infrastructure 


## useful commands for testing the infrastructure

You can use ansible with the terraform.py script from cisco to quickly ping all created instances:

```
ansible -i bin/terraform.py/terraform.py -m ping all

dockernode-02 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
haproxy-01 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
dockernode-01 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}
mongodbnode-01 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
}

```
# provisioning of the hosts

```
ansible-playbook -i terraform/bin/terraform.py/terraform.py ansible/pegski.yml
```


## left todo:
 
 create ansible hostfile
 attach playbooks
 refactor dockerfiles

 
