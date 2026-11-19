# Terraform AWS Static Website

This project uses Terraform to deploy a static website to an Amazon S3 bucket in the `ap-south-1` (Mumbai) AWS region. The included `index.html` page is uploaded to the bucket and served through S3 static website hosting.

## Prerequisites

- [Terraform](https://developer.hashicorp.com/terraform/downloads) 1.0 or later
- AWS account
- AWS CLI or another AWS credential provider
- Permissions to create and manage S3 buckets, bucket policies, and public access settings

Configure AWS credentials before running Terraform:

```powershell
aws configure
```

## Configuration

The S3 bucket name is configured in `variables.tf`.

| Variable | Description | Default |
| --- | --- | --- |
| `bucket_name` | Globally unique name for the S3 bucket | `komal-terraform-static-website-2026` |

Override the default by creating a `terraform.tfvars` file:

```hcl
bucket_name = "your-globally-unique-bucket-name"
```

S3 bucket names must be globally unique across AWS.

## Deploy

From the project directory, run:

```powershell
terraform init
terraform plan
terraform apply
```

Enter `yes` when Terraform asks for confirmation.

## Outputs

After deployment, Terraform displays:

- `s3_bucket_name` - The created S3 bucket name
- `s3_bucket_arn` - The ARN of the S3 bucket
- `website_endpoint` - The public S3 static website URL

Retrieve them again with:

```powershell
terraform output
```

Open the value of `website_endpoint` in a browser to view the website.

## Live Website

[http://komal-terraform-static-website-2026.s3-website.ap-south-1.amazonaws.com](http://komal-terraform-static-website-2026.s3-website.ap-south-1.amazonaws.com/)

## Update the Website

Edit `index.html`, then apply the changes:

```powershell
terraform apply
```

## Destroy

To remove all infrastructure created by this project:

```powershell
terraform destroy
```

The S3 bucket must be empty before Terraform can delete it. Remove any objects or enable and run a suitable cleanup step before destroying the infrastructure.

## Files

- `main.tf` - AWS provider, S3 bucket, website configuration, public access policy, and object upload
- `variables.tf` - Input variable definitions
- `outputs.tf` - Deployment outputs
- `index.html` - Static website content
