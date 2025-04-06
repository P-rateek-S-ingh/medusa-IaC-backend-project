# medusa-IaC-backend-
## 🎦📹🎥Video link:
```bash
https://drive.google.com/file/d/1ZN7x2w-yzw2OOuqQvJdwujpciZqY4mVt/view?usp=sharing
```
# 🚀 Medusa Headless Commerce Deployment on AWS using Terraform

This project provisions infrastructure on AWS to deploy [Medusa](https://medusajs.com/), a modern, open-source, headless commerce engine. It uses **Terraform** for Infrastructure as Code (IaC) to set up and run Medusa on **ECS Fargate**, fronted by an **Application Load Balancer**, with a **PostgreSQL database** hosted on **RDS** and container images stored in **ECR**.

---

## 📦 What is Medusa?

**Medusa** is a Node.js-based headless commerce engine that allows developers to build customizable e-commerce backends with features such as:
- Products, orders, and customer management
- Plugin and event system
- Admin dashboard
- REST and GraphQL APIs
- Multiple sales channels

You can pair Medusa with any frontend (e.g., Next.js, Gatsby, Vue.js) to create modern shopping experiences.

---

## 🔧 Architecture Overview


---

## 📁 Project Structure

├── main.tf # Terraform provider and VPC + ECS module declarations 

├── variables.tf # Input variables (e.g. region, DB credentials) 

├── outputs.tf # Outputs like ALB URL 

├── database.tf # RDS PostgreSQL setup 

├── ecr.tf # ECR repo to store container images 

├── ecs.tf # ECS task and service definitions 

├── alb.tf # Load balancer + listener + target group 

├── security.tf # Security groups for ECS and RDS 

├── README.md 

---

## ⚙️ How It Works

This Terraform project automates the following:

1. **VPC and Subnets**  
   Using the `terraform-aws-modules/vpc/aws` module to create public subnets and networking.

2. **ECR Repository**  
   Creates an Amazon ECR repo named `medusa-repo` to store the Medusa Docker image.

3. **Security Group**  
   Allows access to:
   - Port 9000 (Medusa backend)
   - Port 5432 (PostgreSQL)

4. **RDS PostgreSQL**  
   - Sets up a PostgreSQL database accessible from the ECS cluster
   - Configurable with `db_username` and `db_password` inputs

5. **ECS Fargate Cluster & Task Definition**  
   - Uses the official Medusa image or custom-built one
   - Injects the `DATABASE_URL` environment variable
   - Allocates 512 CPU units and 1024 MiB memory

6. **ALB and Target Group**  
   - Exposes Medusa backend via HTTP on port 80
   - Forwards traffic to ECS service running on port 9000

---

## 🚀 How to Use

### ✅ Prerequisites

- Terraform CLI (`>=1.3`)
- AWS CLI (configured with sufficient permissions)
- Docker (for building & pushing Medusa image)
- An S3 bucket & DynamoDB table for Terraform state (optional for remote state)

---

### 📥 Clone This Repository

```bash
git clone https://github.com/your-org/medusa-terraform-deploy.git
cd medusa-terraform-deploy

```

### 🔐 Set Environment Variables (or use .tfvars)
```bash

export TF_VAR_db_username="medusa_admin"
export TF_VAR_db_password="supersecretpassword"
```

### 🏗️ Deploy Infrastructure

```bash
terraform init
terraform plan
terraform apply

```


### 🐳 Push Medusa Docker Image to ECR
```bash
aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.ap-south-1.amazonaws.com

# Build Medusa image
docker build -t medusa .

# Tag and push
docker tag medusa:latest <your-account-id>.dkr.ecr.ap-south-1.amazonaws.com/medusa-repo:latest
docker push <your-account-id>.dkr.ecr.ap-south-1.amazonaws.com/medusa-repo:latest

```


### 🌐 Access Your Medusa Backend
```bash
load_balancer_url = medusa-alb-XXXX.ap-south-1.elb.amazonaws.com
```

### 🧹 Cleanup
```bash
terraform destroy
```
