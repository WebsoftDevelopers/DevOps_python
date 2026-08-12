#!/bin/bash

# Kill any existing processes on port 8000
echo "🛑 Killing existing processes on port 8000..."
lsof -ti:8000 | xargs kill -9 2>/dev/null || true
pkill -f uvicorn || true
pkill -f "v2.api.app:app" || true
sleep 1

# Load environment variables from .env
if [ -f ".env" ]; then
    echo "📝 Loading environment from .env..."
    set -a
    source .env
    set +a
else
    echo "⚠️  No .env file found"
fi

# Check if virtual environment exists, create if not
if [ ! -d "venv" ]; then
    echo "📦 Virtual environment not found. Creating with Python 3.10..."
    python3.10 -m venv venv || python3 -m venv venv
fi

# Activate virtual environment
echo "🔧 Activating virtual environment..."
source venv/bin/activate

# Install/update dependencies from requirements.txt
echo "📦 Installing/updating dependencies..."
pip install --upgrade pip
pip install --upgrade -r requirements.txt

# Start the app (port 8000 for local development)
echo "🚀 Starting RosieVision ML API on port 8000..."
echo "📍 Database: $DB_HOST:$DB_PORT/$DB_DBNAME"
echo "🔑 API Keys: ${GOOGLE_API_KEY:+SET} ${OPENAI_API_KEY:+SET}"
PYTHONPATH=src uvicorn v2.api.app:app --host 0.0.0.0 --port 8000 --reload
