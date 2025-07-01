#!/bin/bash

echo "🔍 Debugging uni-app build path..."

# Build with debug dockerfile
docker build -f Dockerfile.debug -t ai-finance-frontend:debug .

# Extract build information
echo "📁 Checking build output structure..."
docker run --rm ai-finance-frontend:debug find /app -type f -name "*.html" | head -10
docker run --rm ai-finance-frontend:debug ls -la /app/unpackage/ || echo "unpackage folder not found"
docker run --rm ai-finance-frontend:debug ls -la /app/unpackage/dist/ || echo "unpackage/dist folder not found"
docker run --rm ai-finance-frontend:debug ls -la /app/unpackage/dist/build/h5/ || echo "unpackage/dist/build/h5 folder not found"
docker run --rm ai-finance-frontend:debug ls -la /app/unpackage/dist/dev/h5/ || echo "unpackage/dist/dev/h5 folder not found"

echo "📋 Build completed. Check the output above to see the correct path."
