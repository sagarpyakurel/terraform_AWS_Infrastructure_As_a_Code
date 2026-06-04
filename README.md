# Terraform AWS Infrastructure as Code

This project sets up a complete AWS infrastructure using Terraform with a VPC, public and private subnets, security groups, and EC2 instances.

## Project Architecture

```
VPC (10.0.0.0/16)
├── Public Subnet (10.0.1.0/24)
│   └── Public EC2 Instance (Bastion Host)
│       └── Internet Gateway
├── Private Subnet (10.0.2.0/24)
│   └── Private EC2 Instance
└── Security Groups
    ├── Public SG (SSH from your IP, HTTP/HTTPS from anywhere)
    └── Private SG (SSH only from Public SG)
```

## Prerequisites

Before you begin, ensure you have the following installed:

1. **Terraform** (>= 1.0)
   - Download: https://www.terraform.io/downloads.html
   - Verify installation: `terraform --version`

2. **AWS CLI**
   - Download: https://aws.amazon.com/cli/
   - Verify installation: `aws --version`

3. **SSH Key Pair**
   - Generate an SSH key: `ssh-keygen -t rsa -b 4096 -f ~/.ssh/ssh_key`
   - This creates `~/.ssh/ssh_key` (private) and `~/.ssh/ssh_key.pub` (public)

4. **AWS Credentials**
   - Configure AWS CLI: `aws configure --profile personal`
   - Enter your AWS Access Key ID and Secret Access Key
   - Set default region: `us-east-2`

## Setup Instructions

### Step 1: Clone the Repository

```bash
git clone https://github.com/sagarpyakurel/terraform_AWS_Infrastructure_As_a_Code.git
cd terraform_AWS_Infrastructure_As_a_Code
```

### Step 2: Initialize Terraform

```bash
terraform init
```

This command will:
- Download required providers (AWS)
- Initialize the local `.terraform` directory
- Set up the backend configuration (Terraform Cloud)

### Step 3: Plan the Infrastructure

```bash
terraform plan -var-file="dev.tfvars" -out=planfile
```

This will show you what resources will be created. Review the output to ensure everything looks correct.

### Step 4: Apply the Configuration

```bash
terraform apply planfile
```

Confirm by typing `yes` when prompted. This will create all the AWS resources.

### Step 5: Get the Public EC2 IP

After the infrastructure is created, retrieve the public IP address:

```bash
terraform output public_ec2_public_ip
```

This will display the public IP address of your bastion host.

## SSH Access Guide

### Step 1: SSH into the Public EC2 Instance

Use the public IP from the previous step:

```bash
ssh -i ~/.ssh/ssh_key ec2-user@<PUBLIC_EC2_IP>
```

**Example:**
```bash
ssh -i ~/.ssh/ssh_key ec2-user@54.123.45.67
```

**Troubleshooting:**
- If you get "Permission denied": Make sure the key has correct permissions
  ```bash
  chmod 600 ~/.ssh/ssh_key
  chmod 644 ~/.ssh/ssh_key.pub
  ```
- If you get "Connection refused": Wait 2-3 minutes for the EC2 instance to fully initialize

### Step 2: Copy Your Private Key to the Public EC2 Instance

From your **local machine**, copy your private SSH key to the public EC2 instance:

```bash
scp -i ~/.ssh/ssh_key ~/.ssh/ssh_key ec2-user@<PUBLIC_EC2_IP>:~/.ssh/ssh_key
```

**Example:**
```bash
scp -i ~/.ssh/ssh_key ~/.ssh/ssh_key ec2-user@54.123.45.67:~/.ssh/ssh_key
```

Then, set the correct permissions on the public EC2 instance. First SSH into it:

```bash
ssh -i ~/.ssh/ssh_key ec2-user@<PUBLIC_EC2_IP>
```

Then on the public EC2, run:

```bash
chmod 600 ~/.ssh/ssh_key
```

### Step 3: SSH into the Private EC2 Instance from the Public EC2

While logged into the public EC2 instance, SSH to the private instance using its private IP:

```bash
ssh -i ~/.ssh/ssh_key ec2-user@<PRIVATE_EC2_PRIVATE_IP>
```

Get the private IP address from your local machine:

```bash
terraform output private_ec2_private_ip
```

**Example:**
```bash
# From public EC2 instance
ssh -i ~/.ssh/ssh_key ec2-user@10.0.2.50
```

**Note:** The private EC2 instance is only accessible via the public EC2 instance (bastion host) due to security group rules.

## Common Terraform Commands

### View All Outputs

```bash
terraform output
```

### View Specific Output

```bash
terraform output vpc_cidr_block
terraform output public_ec2_public_ip
terraform output private_ec2_private_ip
```

### Destroy Infrastructure

⚠️ **Warning:** This will delete all AWS resources created by this Terraform configuration.

```bash
terraform destroy -var-file="dev.tfvars"
```

Confirm by typing `yes` when prompted.

### Refresh State

```bash
terraform refresh
```

### Validate Configuration

```bash
terraform validate
```

## Project Files Description

| File | Purpose |
|------|---------|
| `main.tf` | Terraform backend and AWS provider configuration |
| `vpcandsubnets.tf` | VPC, public and private subnets configuration |
| `security_grp.tf` | Security groups for public and private instances |
| `route_table_and_association.tf` | Route tables and subnet associations |
| `instance.tf` | EC2 instances configuration |
| `key_upload.tf` | SSH key pair configuration |
| `output.tf` | Terraform outputs (VPC ID, subnet IDs, EC2 IPs, etc.) |
| `variable.tf` | Variable definitions |
| `dev.tfvars` | Development environment variable values |
| `.gitignore` | Git ignore rules for sensitive files |

## Security Considerations

1. **SSH Access**: Only your IP (71.58.167.103) can SSH into the public instance
   - To change this, edit `security_grp.tf` and update the `myip` local variable

2. **HTTP/HTTPS Access**: Open to the internet (0.0.0.0/0)
   - Modify in `security_grp.tf` if needed

3. **Private EC2**: Only accessible from the public instance
   - Cannot be accessed directly from the internet

4. **SSH Keys**: Never commit private keys to Git
   - The `.gitignore` file protects your keys

## Troubleshooting

### Error: "No valid credential sources found"
- Run: `aws configure --profile personal`
- Verify credentials: `aws sts get-caller-identity --profile personal`

### Error: "Failed to read SSH private key"
- Check key permissions: `chmod 600 ~/.ssh/ssh_key`
- Verify the path in `key_upload.tf` matches your key location

### Instance takes too long to boot
- EC2 instances can take 2-5 minutes to initialize
- Check AWS console for instance status

### Cannot connect to private EC2
- Ensure you're connected to the public EC2 first
- Verify private key is copied to public EC2: `ls -la ~/.ssh/ssh_key`
- Check security group allows SSH: `ec2-user@<PRIVATE_IP>`

## Support and Resources

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC Documentation](https://docs.aws.amazon.com/vpc/)

## License

This project is open source and available under the MIT License.

## Author

Sagar Pyakurel

---

**Last Updated:** June 2026
