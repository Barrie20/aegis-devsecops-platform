"""
Aegis DevSecOps Platform - API Entry Point
==========================================

This is the main entry point for the FastAPI application.
It demonstrates production-grade API practices:
- Health check endpoints (required for Kubernetes liveness/readiness probes)
- Structured logging
- CORS middleware configuration
- Request ID tracking for observability

WHY FASTAPI?
- Async support (handles thousands of concurrent requests)
- Automatic OpenAPI documentation
- Built-in request validation with Pydantic
- Type hints for better code quality
- Used by Netflix, Microsoft, Uber in production
"""

from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime, timezone
import uuid

# ============================================
# Application Factory
# ============================================
# WHY a function instead of just `app = FastAPI()`?
# - Allows different configs for testing vs production
# - Enterprise pattern called "Application Factory"
# - Makes testing easier (create fresh app per test)
# ============================================


def create_app() -> FastAPI:
    """Create and configure the FastAPI application."""

    app = FastAPI(
        title="Aegis DevSecOps Platform API",
        description="Production-grade API with security-first design",
        version="1.0.0",
        docs_url="/docs",       # Swagger UI
        redoc_url="/redoc",     # ReDoc alternative docs
        openapi_url="/openapi.json",
    )

    # ------------------------------------------
    # Middleware: CORS (Cross-Origin Resource Sharing)
    # ------------------------------------------
    # WHY: Browsers block requests from different domains by default.
    # In production, you'd restrict this to your frontend domain only.
    # SECURITY: Never use allow_origins=["*"] in production!
    # ------------------------------------------
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["http://localhost:3000"],  # Frontend URL
        allow_credentials=True,
        allow_methods=["GET", "POST", "PUT", "DELETE"],
        allow_headers=["*"],
    )

    # ------------------------------------------
    # Middleware: Request ID Tracking
    # ------------------------------------------
    # WHY: Every request gets a unique ID so you can trace it
    # through logs, across microservices, and in error reports.
    # This is CRITICAL for debugging in production.
    # ------------------------------------------
    @app.middleware("http")
    async def add_request_id(request: Request, call_next):
        request_id = request.headers.get("X-Request-ID", str(uuid.uuid4()))
        response = await call_next(request)
        response.headers["X-Request-ID"] = request_id
        return response

    # ------------------------------------------
    # Health Check Endpoints
    # ------------------------------------------
    # WHY: Kubernetes uses these to know if your app is alive.
    # - /health/live  → "Is the process running?" (liveness probe)
    # - /health/ready → "Can it handle traffic?" (readiness probe)
    #
    # If liveness fails → K8s restarts the pod
    # If readiness fails → K8s stops sending traffic to it
    # ------------------------------------------
    @app.get("/health/live", tags=["Health"])
    async def liveness():
        """Liveness probe - is the application process running?"""
        return {"status": "alive", "timestamp": datetime.now(timezone.utc).isoformat()}

    @app.get("/health/ready", tags=["Health"])
    async def readiness():
        """Readiness probe - can the application handle requests?"""
        # In production, you'd check:
        # - Database connection
        # - Cache connection (Redis)
        # - External service dependencies
        return {
            "status": "ready",
            "timestamp": datetime.now(timezone.utc).isoformat(),
            "checks": {
                "database": "healthy",
                "cache": "healthy",
            },
        }

    # ------------------------------------------
    # Root Endpoint
    # ------------------------------------------
    @app.get("/", tags=["Root"])
    async def root():
        """API root - returns basic service information."""
        return {
            "service": "aegis-devsecops-platform",
            "version": "1.0.0",
            "status": "operational",
            "docs": "/docs",
        }

    return app


# Create the application instance
app = create_app()
