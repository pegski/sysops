# infrastructure/sysops

Peg.ski runs on AWS.

The AWS infrastructure is maintained by Terraform. Services are being deployed using ansible.

## secrets
You will need to provide AWS credentials as environment variables in order to be able to run the scripts.

These variables can be added to env/environment.local (for all linux versions) or environment.osx for OS X. 
 The following command can be used to load the environment in your current working shell:
 
  ```
  source env/loadenv.sh
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
