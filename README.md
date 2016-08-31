# infrastructure/sysops

Peg.ski runs on AWS.

The AWS infrastructure is maintained by Terraform. Services are being deployed using ansible.

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

## deploy
 
 The docker host can be provisioned using:
 
 ```
 ansible-playbook site.yml -i hosts
 ```
 
 You are able to add your own ssh-key and it will be deployed to the server so you can log in.
 
 Add your ssh public key to ssh_access/files/public_keys and reference the file in ssh_access/vars/main.yml.
 
 Deploy the keys with:
 ```
 ansible-playbook -i hosts site.yml --tags "ssh_access"
 ```
 
 
 After this, webski can be deployed from github by using:
 ```
 ansible-playbook -i hosts site.yml deploy/pegski.yml
 ```
