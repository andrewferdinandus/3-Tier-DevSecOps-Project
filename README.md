# 🚀 3-Tier DevSecOps Project on AWS EKS

## 📌 Project Overview

This project demonstrates a complete end-to-end DevSecOps workflow for deploying a 3-tier application into Amazon EKS using Jenkins, Terraform, Docker, and Kubernetes.

The platform automates:

- Infrastructure provisioning
- CI/CD pipeline execution
- Docker image management
- Security scanning
- Kubernetes deployments
- Persistent storage provisioning
- Application rollout validation

The project was designed to simulate a production-style cloud-native deployment workflow using modern DevOps practices.

---

# 🏗️ Architecture

The application follows a traditional 3-tier architecture:

### Frontend
- React application
- Served through NGINX
- Exposed publicly using AWS LoadBalancer

### Backend
- Node.js API service
- Internal Kubernetes service communication

### Database
- MySQL database
- Persistent storage using AWS EBS CSI Driver

---

# ⚙️ Technologies Used

| Category | Technology |
|---|---|
| CI/CD | Jenkins |
| Infrastructure as Code | Terraform |
| Containerization | Docker |
| Orchestration | Kubernetes (EKS) |
| Cloud Provider | AWS |
| Code Quality | SonarQube |
| Vulnerability Scanning | Trivy |
| Secret Detection | Gitleaks |
| Frontend | React + NGINX |
| Backend | Node.js |
| Database | MySQL |
| Persistent Storage | AWS EBS CSI |

---

# 🔄 CI/CD Pipeline Workflow

The Jenkins pipeline automates the entire software delivery lifecycle.

## Pipeline Stages

### ✅ Source Code Checkout
- Pulls latest code from GitHub

### ✅ Frontend & Backend Validation
- Performs basic validation checks

### ✅ Security Scanning
- Gitleaks for secret detection
- Trivy for filesystem and image vulnerability scanning

### ✅ Code Quality Analysis
- SonarQube integration for static analysis

### ✅ Docker Build & Push
- Builds frontend and backend Docker images
- Pushes versioned images to Docker Hub

### ✅ Infrastructure Provisioning
- Terraform provisions AWS infrastructure
- Deploys VPC, EKS, IAM roles, and networking

### ✅ Kubernetes Deployment
- Deploys frontend, backend, and database into EKS
- Performs rollout verification

---

# ☁️ Infrastructure Provisioning

Terraform provisions:

- AWS VPC
- Public and private subnets
- NAT Gateway
- Amazon EKS Cluster
- Managed Node Groups
- IAM Roles
- EBS CSI Driver Integration

Infrastructure state management is configured using a remote S3 backend.

---

# 🐳 Docker Strategy

The project uses optimized Docker builds for efficient deployments.

### Frontend Container
- Multi-stage Docker build
- React build separated from runtime image
- NGINX used for static content delivery and API proxying

### Backend Container
- Lightweight Node.js container
- Environment-based configuration

Docker image versioning is automated through Jenkins build numbers.

---

# ☸️ Kubernetes Deployment

The application is deployed into Amazon EKS using Kubernetes manifests.

The deployment setup includes:

- Frontend Deployment & Service
- Backend Deployment & Service
- MySQL Deployment & Service
- PersistentVolumeClaim
- StorageClass
- LoadBalancer exposure for frontend access

The frontend communicates with the backend internally through Kubernetes services.

---

# 🔐 DevSecOps Practices Implemented

This project integrates multiple DevSecOps practices:

- Infrastructure as Code
- Automated CI/CD
- Security scanning inside the pipeline
- Secret detection
- Code quality validation
- Automated deployment rollouts
- Container image versioning
- Persistent storage management
- Kubernetes service orchestration

---

# 📚 Key Lessons Learned

Working on this project helped strengthen my understanding of:

- Kubernetes networking and service discovery
- CI/CD automation workflows
- Infrastructure as Code principles
- Persistent storage management in Kubernetes
- AWS IAM and IRSA integration
- Container image optimization
- Kubernetes deployment orchestration
- Security integration in CI/CD pipelines
- Terraform state management
- Troubleshooting distributed cloud-native systems

---

# 🚀 Future Improvements

Planned future enhancements include:

- ArgoCD GitOps workflows
- Helm chart deployments
- Prometheus & Grafana monitoring
- Horizontal Pod Autoscaling
- AWS ALB Ingress Controller
- Centralized logging
- TLS automation with cert-manager
- Multi-environment deployment pipelines

---

# 📸 Project Screenshots

Suggested screenshots to include:

- Jenkins Pipeline Success
- SonarQube Dashboard
- Trivy Scan Results
- Docker Hub Images
- Terraform Apply Output
- Kubernetes Pods & Services
- AWS LoadBalancer Access
- Application UI

---

# 📂 Repository Structure

```text
.
├── api/
├── client/
├── k8s/
├── terraform/
├── Jenkinsfile
├── docker-compose.yaml
└── production.env
```

---

# 🌐 Application Access

The frontend application is exposed publicly using an AWS LoadBalancer service.

The backend and database services remain internal to the Kubernetes cluster.

---

# 📖 Medium / LinkedIn Article

A detailed write-up of this project covering architecture, deployment workflow, and lessons learned is available in my Medium and LinkedIn articles.

---

# 🤝 Connect With Me

If you found this project useful, feel free to connect with me on LinkedIn and follow my future DevOps and cloud engineering projects.


