# ============================================
# Multi-Stage Dockerfile - Aegis API
# ============================================
# WHY MULTI-STAGE?
# - Stage 1 (builder): Install dependencies (large, has build tools)
# - Stage 2 (production): Only copy what's needed (small, secure)
#
# RESULT: Smaller image = faster deploys + smaller attack surface
#
# SECURITY BEST PRACTICES USED HERE:
# 1. Pin base image version (never use :latest)
# 2. Run as non-root user
# 3. Minimal base image (slim variant)
# 4. No unnecessary packages
# 5. Copy only what's needed
# ============================================

# ---------- Stage 1: Builder ----------
# This stage installs all dependencies.
# It will be DISCARDED in the final image.
FROM python:3.11-slim as builder

# Set working directory inside the container
WORKDIR /app

# Install system dependencies needed for building Python packages
# --no-install-recommends: Don't install optional packages (smaller image)
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

# Copy only requirements first (Docker layer caching optimization)
# WHY: If requirements.txt hasn't changed, Docker reuses this layer
# instead of reinstalling all packages. Saves minutes in CI/CD.
COPY apps/api/requirements.txt .

# Install Python dependencies into a specific directory
# --no-cache-dir: Don't store pip cache (smaller image)
# --prefix: Install to /install so we can copy just these files
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# ---------- Stage 2: Production ----------
# This is the FINAL image that gets deployed.
# It only contains the runtime - no build tools, no cache.
FROM python:3.11-slim as production

# Security: Create a non-root user
# WHY: If an attacker exploits your app, they can't access the host system
# Running as root in containers is a critical security vulnerability
RUN groupadd -r appuser && useradd -r -g appuser -d /app -s /sbin/nologin appuser

# Set working directory
WORKDIR /app

# Copy installed dependencies from builder stage
COPY --from=builder /install /usr/local

# Copy application code
COPY apps/api/ .

# Change ownership to non-root user
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose the port the app runs on
# NOTE: This is documentation only - doesn't actually publish the port
EXPOSE 8000

# Health check - Docker will monitor this
# Kubernetes has its own probes, but this helps with docker-compose
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health/live')" || exit 1

# Run the application
# --host 0.0.0.0: Listen on all interfaces (required in containers)
# --port 8000: Match the EXPOSE above
# --workers 4: Number of worker processes (adjust based on CPU cores)
# --no-access-log: Disable access log (use structured logging instead)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000", "--workers", "4", "--no-access-log"]
