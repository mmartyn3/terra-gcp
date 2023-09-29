# terra-gcp - Example of using Terraform on GCP

A simple example of using infrastructure-as-code (IAC) i.e. Terraform to set up a simple static site on Google Cloud Platform (GCP) via Cloud Storage

## Steps
### Google Cloud setup
1. Create a new project on the [Google Cloud console](https://console.cloud.google.com/)
2. Create a service account for Terraform to use in the new project. Remember to use the minimal credentials principle. In this example we only need Cloud Storage access.
3. Create a new JSON key for the service account and download it locally.
### Install Terraform
4. Install the Terraform command line interface (CLI) for your operating system (OS). Either see the official Hashicorp [instructions](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) or use the below commands for your OS:
	a. **Mac** - `brew tap hashicorp/tap` then `brew install hashicorp/tap/terraform`
	b. **Windows** install - `choco install terraform`
	c. **Ubuntu** install - `sudo apt-get update && sudo apt-get install -y gnupg software-properties-common` then `wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg` then `gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint`
### Write the Terraform files (or clone this repo and skip to the build section)
5. Specify Google Cloud as your desired location in the `providers.tf` file (`.tf` extension is for Terraform files)
6. Store the service account path, project, and region variables in `terraform.tfvars`
7. Make a variables template file (`variables.tf`) to use the stored variables from step 5 
8. Create the main terraform file `main.tf`. In this file we use the Google Cloud / Terraform API bindings to create a new bucket in Google Cloud Storage, make the bucket public to allow anyone to view the HTML file, then upload the HTML file to the bucket.
9. Note - you will need to change line 6 of `main.tf` as bucket names always need to be globally unique within GCP. Sorry I already took the name in these files!
### Build the GCP infrastructure using Terraform 
10. Init Terraform in the cloned repo. First `cd ~/terra-gcp/infra` then initialise Terraform here `terraform init`. This will create a lock file `infra/.terraform.lock.hcl`
11. See what Terraform understands from your files by running `terraform plan` - for this example it should say `Plan: 3 to add, 0 to change, 0 to destroy.`. If this seems inline with your plans you can proceed to build it.
12.  Lets build! To get Terraform to make the GCP infrastructure for us, we run `terraform apply` - Terraform will inform you of the additions/changes/deletions it plans to make, before asking you to confirm the plan. If successful you should see `Apply complete! Resources: 3 added, 0 changed, 0 destroyed.`
13. Head back to the GCP console and check for a new bucket called whatever you changed line 6 to in Step 9 of these instructions. You will see a single `index.html` file in the new bucket. Click the Public URL (something like `https://storage.googleapis.com/terraform-bucket/index.html`) to see the static site!
### Modify the GCP infrastructure using Terraform
14. Make a change to the `index.html` file then run `terraform apply` to push the changes. Terraform will pick up the alterations and display `Plan: 1 to add, 0 to change, 1 to destroy.`
### Destroy the GCP infrastructure using Terraform
15. Time to tear down the bucket and its contents in a single Terraform swoop using `terraform destroy`
