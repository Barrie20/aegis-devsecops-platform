#!/bin/bash
# ============================================
# Aegis Platform - Setup Script
# ============================================
# This script sets up the local development environment.
# Run this once when you first clone the repository.
#
# USAGE: ./scripts/setup.sh
# ============================================

set -euo pipefail  # Exit on error, undefined vars, pipe failures

echo "🛡️  Aegis DevSecOps Platform - Setup"
echo "============================================"

# Check prerequisites
echo "📋 Checking prerequisites..."

command -v python3 >/dev/null 2>&1 || { echo "❌ Python 3 is required but not installed."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "❌ Docker is required but not installed."; exit 1; }
command -v git >/dev/null 2>&1 || { echo "❌ Git is required but not installed."; exit 1; }

echo "✅ All prerequisites found"

# Create Python virtual environment
echo "🐍 Creating Python virtual environment..."
python3 -m venv venv
source venv/bin/activate

# Install dependencies
echo "📦 Installing Python dependencies..."
pip install --upgrade pip
pip install -r apps/api/requirements.txt

# Create .env file from example (if it doesn't exist)
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp .env.example .env
    echo "⚠️  Please update .env with your local settings"
fi

echo ""
echo "============================================"
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  1. Update .env with your settings"
echo "  2. Run 'make dev' to start the API"
echo "  3. Visit http://localhost:8000/docs for API docs"
echo "============================================"
