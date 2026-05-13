# Contributing to Aegis DevSecOps Platform

Thank you for your interest in contributing! This document provides guidelines and standards for contributing to this project.

## Development Workflow

We follow a trunk-based development workflow with short-lived feature branches.

### Branch Naming Convention

```
feature/   — New features (e.g., feature/add-rate-limiting)
fix/       — Bug fixes (e.g., fix/auth-token-expiry)
docs/      — Documentation updates (e.g., docs/update-runbook)
refactor/  — Code refactoring (e.g., refactor/api-middleware)
security/  — Security improvements (e.g., security/update-dependencies)
infra/     — Infrastructure changes (e.g., infra/add-waf-rules)
```

### Commit Message Convention

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]

[optional footer]
```

**Types:**
- `feat` — New feature
- `fix` — Bug fix
- `docs` — Documentation only
- `style` — Formatting, no code change
- `refactor` — Code restructuring
- `test` — Adding or updating tests
- `chore` — Maintenance tasks
- `security` — Security improvements
- `ci` — CI/CD pipeline changes

**Examples:**
```
feat(api): add health check endpoint with dependency status
fix(auth): resolve token refresh race condition
docs(runbook): add database failover procedure
security(deps): update fastapi to patch CVE-2024-XXXX
ci(pipeline): add container image scanning stage
```

## Pull Request Process

1. Create a feature branch from `main`
2. Make your changes with clear, atomic commits
3. Ensure all CI checks pass (tests, linting, security scan)
4. Update documentation if needed
5. Request review from at least one maintainer
6. Squash and merge after approval

### PR Checklist

- [ ] Code follows project style guidelines
- [ ] Tests added/updated for changes
- [ ] Documentation updated
- [ ] No secrets or credentials in code
- [ ] Security implications considered
- [ ] CI pipeline passes

## Code Standards

### Python
- Follow PEP 8 style guide
- Use type hints for all function signatures
- Docstrings for all public functions (Google style)
- Maximum line length: 100 characters

### Terraform
- Use consistent naming: `snake_case` for resources
- Tag all resources with required tags
- Document all variables and outputs
- Use modules for reusable components

### Docker
- Use multi-stage builds
- Pin base image versions (never use `latest`)
- Run as non-root user
- Minimize layer count and image size

### Kubernetes
- Use resource limits and requests
- Define pod disruption budgets
- Use network policies
- Follow least-privilege RBAC

## Local Development Setup

```bash
# Install dependencies
make setup

# Run locally
make dev

# Run tests
make test

# Run linting
make lint

# Run security scan
make security-scan
```

## Questions?

Open a GitHub Discussion or reach out to the maintainers.
