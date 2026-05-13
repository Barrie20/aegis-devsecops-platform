# Falco Runtime Security

## What is Falco?

Falco is a runtime security tool that detects unexpected behavior in containers and hosts. Think of it as a security camera for your Kubernetes cluster.

## What Falco Detects

- Container running as root
- Unexpected process spawned in container
- Sensitive file access (e.g., /etc/shadow)
- Network connections to suspicious IPs
- Shell spawned inside a container
- Privilege escalation attempts

## Configuration

Custom Falco rules for the Aegis platform will be added here as we build out the security layer.

## Why Runtime Security Matters

Static scanning (Trivy) catches known vulnerabilities BEFORE deployment.
Runtime security (Falco) catches suspicious BEHAVIOR during execution.

You need BOTH for defense in depth.
