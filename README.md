## Azure images

### Requirements
- Docker
- Git

### How to use it?
- Clone the repository
- Export some Environment Variables. You can either add them in ~/.profile or /etc/environment and then source those files.
```
export ARM_CLIENT_ID="The client ID of your resource group"
export ARM_CLIENT_SECRET="The client Secret of your resource group"
export ARM_TENANT_ID="The tenant ID of your resource group"
export ARM_SUBSCRIPTION_ID="The subscription ID of your resource group"
export RESOURCE_GROUP_NAME="Your resource group name"
export ADMIN_USERNAME=ubuntu
export ADMIN_PASSWORD="AStrongPassword" # Choose a strong password!!
export SERVER_SIZE=Standard_D2d_v5 # this is 2 CPUs and 8GB Memory
export STORAGE_ACCOUNT_NAME="the storage account name" # Example: imagesstorage (Created by Terraform)
export STORAGE_CONTAINER_NAME="the storage container name" # Example: imagescontainer (Created by Terraform)
export STATE_STORAGE_ACCOUNT_NAME="the state storage account name" # Example: terraformstorage (Created manually)
export STATE_STORAGE_CONTAINER_NAME="the state storage container name" # Example: terraformcontainer (Created manually)
export ALLOWED_IPS='["83.147.179.166/32", "83.147.179.167/32"]' # It is a list of allowed IPs to the servers
export AMOUNT=2
```
- Create a storage account and container to store the Terraform State following: https://learn.microsoft.com/en-us/azure/storage/blobs/storage-quickstart-blobs-portal
- Run `bash azure-images.sh create`. Every time you add/remove a server you need to run this command so the Terraform State can be updated.
- If you want to delete all the resources (including the bucket), run `bash azure-images delete`
- Once Terraform finishes, you can access the server by running `ssh ubuntu@IP_OF_THE_SERVER`

### Important notes
- If the amount of current servers is 5 and you increase it to 6, it will deploy a new server
- If the amount of current servers is 5 and you decrease it to 4, it will delete the latest server that was added (server-vm-5)
- The servers communicate over their private network but they don't have access to the public internet
- By default all the servers run on Ubuntu 22
- By default all the servers are deployed in West Europe
