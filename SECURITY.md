# Security Policy

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| 1.x.x  | ✅ Active support  |
| < 1.0   | ❌ No support     |

## Reporting a Vulnerability

We take security seriously. If you discover a security vulnerability, please report it responsibly.

### How to Report

1. **DO NOT** open a public GitHub issue for security vulnerabilities
2. Email: security@your-domain.com (replace with your actual contact)
3. Include:
   - Description of the vulnerability
   - Steps to reproduce
   - Potential impact
   - Suggested fix (if any)

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 5 business days
- **Resolution**: Depends on severity (Critical: 7 days, High: 14 days, Medium: 30 days)

### Security Measures in This Project

- All dependencies are pinned to specific versions
- Container images are scanned with Trivy on every build
- Secrets are managed through AWS Secrets Manager (never hardcoded)
- Infrastructure follows least-privilege IAM policies
- Network segmentation via VPC with private subnets
- TLS encryption for all data in transit
- Encryption at rest for all data stores
- Runtime security monitoring with Falco

## Security Best Practices

When contributing to this project:

1. Never commit secrets, tokens, or credentials
2. Use environment variables or secrets managers for sensitive data
3. Keep dependencies updated and review security advisories
4. Follow the principle of least privilege in IAM policies
5. Validate and sanitize all user inputs
6. Use parameterized queries to prevent SQL injection
7. Enable audit logging for all security-relevant operations
