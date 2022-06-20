# Infrastructure

## Required software
- [Terraform](https://www.terraform.io/downloads.html)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

All of the follow instructions assume that you have downloaded/installed the above software.
For the Azure CLI, this will also assume that you have properly authenticated using `az login` as well as set the appropriate subscription using `az account set --subscription <subscription>`.

## Pre-Setup
Terraform requires a location to [store its state](https://www.terraform.io/docs/language/state/index.html). Because we want a centralized location for this, we will store it inside of a storage account in Azure. This storage account must be created manually, before running the terraform scripts.
To do this run the following commands (adjusting values as necessary):
- If you don't care about using the CLI, it's probably easier to just manually create this in the AWS console.
- To use the CLI you'll need a user setup in IAM
- https://us-east-1.console.aws.amazon.com/iamv2/home#/users
- This user will need access to create S3 buckets
- You'll need the AWS access key id, Secret Access Key, and a default region (us-west-2)
- [AWS configure help] `https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html`
- Configure AWS CLI - `aws configure`
- [AWS CLI reference S3] (https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/create-bucket.html)
- Create the S3 bucket `aws s3api create-bucket --bucket jm-terraform-state-demo --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2`

- Update the providers.tf with your values for the backend storage.
- For the GitHub Action to run, it will require a service principle create. This command only authorizes this service principle for the dev environment. It will either need a second service principle created for prod, or an additional scope added here. Be aware that the IaC (infrastructure as code) service principles will typically need broad control over the environment, while the ones used to deploy solutions onto th architecture can be much more limited in scope. In addition, for this project the SP running the terraform will also need API permissions for Microsoft Graph - Directory.ReadWrite.All An example of a SP for running the terraform scripts is shown below:
`az ad sp create-for-rbac --name "DEMO-SP" --role owner --sdk-auth --scopes /subscriptions/{subscription-id}`

The output from this command should be stored in a [GitHub secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets) named AZURE_CREDENTIALS. For this sample we are storing them as an GitHub Environment secret with the assumption there is a second service principle for prod. This follows the directions [here](https://github.com/marketplace/actions/azure-cli-action#configure-azure-credentials-as-github-secret)

## Creating the infrastructure
- Navigate to the environment folder to create. This will be under the `Infrastructure\env` directory.
- If this is your first run, or there are changes to the terraform providers, you will need to run `terraform init`. After the initial run, you can skip this step.
- Run `terraform apply`
- Review the created plan.
- Enter "yes" to proceed with creating the infrastructure

## Destroying the infrastructure
- Navigate to the environment folder to create. This will be under the `Infrastructure\env` directory.
- Run `terraform destroy`
- Review the created plan.
- Enter "yes" to proceed with destroying the infrastructure