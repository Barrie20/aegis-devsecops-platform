"""
Health Check Endpoint Tests
============================

WHY TEST HEALTH ENDPOINTS?
- They're the first thing Kubernetes checks
- If they break, your entire deployment fails
- They validate your app can start correctly

TESTING PATTERN:
- Use TestClient (synchronous wrapper for async FastAPI)
- Test both success and expected response structure
- These run in CI/CD on every push
"""

from fastapi.testclient import TestClient

from main import app

client = TestClient(app)


def test_liveness_returns_200():
    """Liveness probe should always return 200 if the process is running."""
    response = client.get("/health/live")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "alive"
    assert "timestamp" in data


def test_readiness_returns_200():
    """Readiness probe should return 200 when all dependencies are healthy."""
    response = client.get("/health/ready")
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "ready"
    assert "checks" in data


def test_root_returns_service_info():
    """Root endpoint should return basic service information."""
    response = client.get("/")
    assert response.status_code == 200
    data = response.json()
    assert data["service"] == "aegis-devsecops-platform"
    assert data["version"] == "1.0.0"
    assert "docs" in data
