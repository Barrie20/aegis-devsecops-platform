# 🛡️ Aegis DevSecOps Platform

[![CI Pipeline](https://github.com/YOUR_USERNAME/aegis-devsecops-platform/actions/workflows/ci.yml/badge.svg)](https://github.com/YOUR_USERNAME/aegis-devsecops-platform/actions/workflows/ci.yml)
[![Security Scan](https://github.com/YOUR_USERNAME/aegis-devsecops-platform/actions/workflows/security.yml/badge.svg)](https://github.com/YOUR_USERNAME/aegis-devsecops-platform/actions/workflows/security.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> A production-grade DevSecOps platform demonstrating enterprise security practices, infrastructure automation, and cloud-native architecture.

## 📋 Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Security](#security)
- [Monitoring](#monitoring)
- [Contributing](#contributing)
- [License](#license)

## Overview

Aegis is a comprehensive DevSecOps platform that implements:

- **Secure API** — Python FastAPI application with authentication, input validation, and rate limiting
- **Infrastructure as Code** — Terraform modules for AWS (VPC, ECS/EKS, RDS, IAM)
- **Container Security** — Multi-stage Docker builds with vulnerability scanning (Trivy)
- **CI/CD Pipeline** — GitHub Actions with security gates, testing, and automated deployment
- **Kubernetes Deployment** — Helm charts with Kustomize overlays for multi-environment support
- **Observability** — Prometheus metrics, Grafana dashboards, structured logging
- **Runtime Security** — Falco rules for anomaly detection
- **GitOps** — ArgoCD for declarative, auditable deployments

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        INTERNET                                   │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                    ┌──────────▼──────────┐
                    │   AWS ALB / Ingress  │
                    │   (TLS Termination)  │
                    └──────────┬──────────┘
                               │
              ┌────────────────▼────────────────┐
              │         Kubernetes Cluster       │
              │  ┌───────────────────────────┐  │
              │  │   Aegis API (FastAPI)     │  │
              │  │   - Auth middleware       │  │
              │  │   - Rate limiting         │  │
              │  │   - Input validation      │  │
              │  └─────────────┬─────────────┘  │
              │                │                 │
              │  ┌─────────────▼─────────────┐  │
              │  │   PostgreSQL (RDS)         │  │
              │  │   - Encrypted at rest     │  │
              │  │   - Private subnet only   │  │
              │  └───────────────────────────┘  │
              │                                 │
              │  ┌───────────────────────────┐  │
              │  │   Monitoring Stack        │  │
              │  │   - Prometheus            │  │
              │  │   - Grafana               │  │
              │  │   - Falco                 │  │
              │  └───────────────────────────┘  │
              └─────────────────────────────────┘
```

## Tech Stack

| Category | Technology | Purpose |
|----------|-----------|---------|
| Application | Python, FastAPI | REST API with async support |
| Containerization | Docker | Multi-stage secure builds |
| Orchestration | Kubernetes, Helm | Container orchestration |
| Infrastructure | Terraform | Infrastructure as Code |
| CI/CD | GitHub Actions | Automated pipelines |
| GitOps | ArgoCD | Declarative deployments |
| Monitoring | Prometheus, Grafana | Metrics and dashboards |
| Security | Trivy, Falco, OPA | Scanning and runtime security |
| Cloud | AWS | VPC, EKS, RDS, IAM |
| Secrets | AWS Secrets Manager | Secure secrets storage |

## Getting Started

### Prerequisites

- Docker >= 24.0
- Python >= 3.11
- Terraform >= 1.5
- kubectl >= 1.28
- Helm >= 3.12
- AWS CLI v2 (configured)

### Quick Start

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/aegis-devsecops-platform.git
cd aegis-devsecops-platform

# Run the setup script
make setup

# Start local development environment
make dev

# Run tests
make test

# Run security scan
make security-scan
```

## Project Structure

```
aegis-devsecops-platform/
├── .github/              # CI/CD pipelines and GitHub configs
├── apps/api/             # FastAPI application source code
├── infra/terraform/      # Terraform infrastructure modules
├── k8s/                  # Kubernetes manifests (Kustomize)
├── helm/                 # Helm charts for deployment
├── docker/               # Dockerfiles (multi-stage builds)
├── scripts/              # Automation and utility scripts
├── monitoring/           # Prometheus rules, Grafana dashboards
├── security/             # Security policies and scan configs
├── docs/                 # Documentation, ADRs, runbooks
└── tests/                # Integration and end-to-end tests
```

## Security

Security is integrated at every stage of the development lifecycle:

1. **Code** — Static analysis, dependency scanning, secret detection
2. **Build** — Container image scanning, SBOM generation
3. **Deploy** — Policy enforcement, admission controllers
4. **Runtime** — Anomaly detection, audit logging

See [SECURITY.md](SECURITY.md) for our security policy and vulnerability reporting process.

## Monitoring

The platform includes a full observability stack:

- **Metrics** — Prometheus with custom application metrics
- **Dashboards** — Grafana with pre-built dashboards for API health, infrastructure, and security
- **Alerting** — Alert rules for SLO violations and security events
- **Logging** — Structured JSON logging with correlation IDs

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development workflow, coding standards, and PR process.

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.

---

**Built with security-first principles for learning enterprise DevSecOps practices.**
