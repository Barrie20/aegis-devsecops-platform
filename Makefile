# ============================================
# Aegis DevSecOps Platform - Makefile
# ============================================
# WHY A MAKEFILE?
# - Single entry point for all common commands
# - New engineers can run `make help` to see all available commands
# - Consistent across all environments (local, CI/CD)
# - Self-documenting (each target has a description)
#
# USAGE:
#   make help          — Show all available commands
#   make setup         — First-time project setup
#   make dev           — Start local development
#   make test          — Run all tests
#   make security-scan — Run security scanning
# ============================================

.PHONY: help setup dev test lint security-scan docker-build docker-run clean

# Default target — shows help
help: ## Show this help message
	@echo "============================================"
	@echo "  Aegis DevSecOps Platform - Commands"
	@echo "============================================"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

# ---------- Setup ----------

setup: ## Initial project setup (install dependencies)
	@echo "🔧 Setting up Aegis DevSecOps Platform..."
	cd apps/api && pip install -r requirements.txt
	@echo "✅ Setup complete!"

# ---------- Development ----------

dev: ## Start local development environment
	@echo "🚀 Starting local development..."
	cd apps/api && uvicorn main:app --reload --host 0.0.0.0 --port 8000

# ---------- Testing ----------

test: ## Run all tests
	@echo "🧪 Running tests..."
	cd apps/api && python -m pytest tests/ -v --cov=. --cov-report=term-missing

lint: ## Run code linting
	@echo "🔍 Running linters..."
	cd apps/api && python -m flake8 . --max-line-length=100
	cd apps/api && python -m mypy . --ignore-missing-imports

# ---------- Docker ----------

docker-build: ## Build Docker image
	@echo "🐳 Building Docker image..."
	docker build -f docker/Dockerfile -t aegis-api:latest .

docker-run: ## Run Docker container locally
	@echo "🐳 Running Docker container..."
	docker run -p 8000:8000 --env-file .env.example aegis-api:latest

# ---------- Security ----------

security-scan: ## Run security scanning (Trivy)
	@echo "🔒 Running security scan..."
	trivy fs --severity HIGH,CRITICAL .
	@echo "🔒 Scanning Docker image..."
	trivy image aegis-api:latest

# ---------- Infrastructure ----------

tf-init: ## Initialize Terraform
	@echo "🏗️  Initializing Terraform..."
	cd infra/terraform && terraform init

tf-plan: ## Plan Terraform changes
	@echo "🏗️  Planning infrastructure changes..."
	cd infra/terraform && terraform plan -out=tfplan

tf-apply: ## Apply Terraform changes (requires approval)
	@echo "🏗️  Applying infrastructure changes..."
	cd infra/terraform && terraform apply tfplan

# ---------- Kubernetes ----------

k8s-deploy-dev: ## Deploy to development cluster
	@echo "☸️  Deploying to development..."
	kubectl apply -k k8s/overlays/dev/

k8s-deploy-prod: ## Deploy to production cluster
	@echo "☸️  Deploying to production..."
	kubectl apply -k k8s/overlays/prod/

# ---------- Cleanup ----------

clean: ## Clean up generated files and artifacts
	@echo "🧹 Cleaning up..."
	find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	rm -rf .pytest_cache htmlcov .coverage
	@echo "✅ Cleanup complete!"
