# Three-Tier Web Application Deployment using Terraform, Shell Scripts, and Jenkins

## Overview

This project automates the deployment of a three-tier web application (React frontend, Node.js backend, and MongoDB database) on AWS. It uses:

* **Terraform** for infrastructure provisioning
* **Shell Scripts** for server configuration and application deployment
* **Jenkins** for CI/CD pipeline automation

> 🔧 **Note**: Although the original problem statement suggested using Ansible, we opted for a simpler and more streamlined approach using **shell scripts and Jenkins pipeline**.

---

## Architecture

```
                 +-----------------+
                 |    Internet     |
                 +--------+--------+
                          |
                     [Public Subnet]
                          |
             +------------v------------+
             |  EC2 Instance: Frontend |
             +------------+------------+
                          |
                     [Private Subnet]
                          |
       +------------------v------------------+
       | EC2 Instance: Backend (Node + API) |
       +------------------+------------------+
                          |
              +-----------v----------+
              | EC2 Instance: MongoDB|
              +----------------------+
```

---

## Project Structure

```
three-tier-app-deployment/
├── terraform/
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── scripts/
│       ├── backend_setup.sh
│       └── frontend_setup.sh
├── jenkins/
│   └── Jenkinsfile
├── screenshots/
│   └── [all required screenshots]
└── README.md
```

---

## Tools Used

* **Terraform**: Provisioning AWS infrastructure
* **Jenkins**: CI/CD orchestration
* **Shell Scripts**: Backend and frontend setup
* **AWS EC2**: Hosting all tiers

---

## Prerequisites

* Terraform installed
* AWS CLI configured
* Jenkins installed and running
* Git repository access with TravelMemory source code
* A public/private key pair in AWS

---

## Step-by-Step Guide

### 1. Infrastructure Provisioning (Terraform)

Run the following commands from the `terraform/` root directory:

```bash
cd terraform/
terraform init
terraform apply -auto-approve
```

This will:

* Create a VPC, public/private subnets, Internet and NAT Gateways
* Create EC2 instances for frontend, backend, and MongoDB
* Set up security groups with appropriate access

### 2. Capture IPs

If you want to hardcode IPs in the scripts:

* Get the public IP of the **frontend EC2** (it has `associate_public_ip = true`)
* Get the **private IP** of the backend and MongoDB EC2s from the AWS Console

### 3. Shell Script Updates

Update these variables inside `scripts/backend_setup.sh`:

```bash
MONGO_URI="mongodb://<DB_PRIVATE_IP>:27017/travelmemory"
```

Update these variables inside `scripts/frontend_setup.sh`:

```bash
REACT_APP_BACKEND_URL="http://<BACKEND_PRIVATE_IP>:3001"
```

### 4. Jenkins Configuration

1. Create a new **Jenkins Pipeline job**
2. Add AWS credentials (if required)
3. Use the `Jenkinsfile` from the repo

### 5. Jenkins Pipeline Execution

The Jenkins pipeline will:

* Run Terraform to provision infra (optional)
* SCP the shell scripts and source code to EC2 instances
* Run the setup scripts via SSH
* Validate deployment

---

## .env Files

**For Backend** (create in backend root directory):

```
MONGO_URI='mongodb://<db_private_ip>:27017/travelmemory'
PORT=3001
```

**For Frontend** (create in frontend root directory):

```
REACT_APP_BACKEND_URL=http://<backend_private_ip>:3001
```

---

## Screenshot 

Include screenshots of:

* Terraform `apply` output
  
  ![Screenshot 2025-05-03 112634](https://github.com/user-attachments/assets/69682f73-a75e-418b-90ea-177c0173b9c0)

  ![Screenshot 2025-05-03 113941](https://github.com/user-attachments/assets/3509d57a-63ab-4d6c-abff-ecd431b61dcc)

* EC2 instances list in AWS Console
   ![Screenshot 2025-05-03 114501](https://github.com/user-attachments/assets/bac50f4a-9688-4313-96fa-cb2aeed00958)

* SSH into each instance
* Running `node` or `npm start` commands
* Jenkins pipeline execution
* Application running in browser



---

## Troubleshooting

### Terraform Outputs Not Found

* Run `terraform apply` again to refresh state
* Ensure outputs are defined in correct `outputs.tf`

### Public IP Not Available

* Check that `associate_public_ip_address = true` for the instance
* Check if your subnet is public (has route to Internet Gateway)

### App Not Connecting to DB

* Check security group allows backend to access MongoDB on port 27017
* Verify MongoDB service is running

### Jenkins SSH Issues

* Make sure Jenkins host has access to the EC2 key pair
* Use `chmod 400` on PEM key and correct path in shell

---

## Final Note

This project demonstrates a production-like setup using DevOps best practices with minimal tooling and is easily extensible to Ansible or Docker/Kubernetes if required later.

---

## Author

Reshma – DevOps Engineer (Assignment Project)
