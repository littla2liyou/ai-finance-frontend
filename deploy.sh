#!/bin/bash

echo "🚀 Starting AI Finance Frontend Development..."

# Check if docker and docker-compose are installed
if ! command -v docker &> /dev/null; then
    echo "❌ Docker is not installed. Please install Docker first."
    exit 1
fi

if ! command -v docker-compose &> /dev/null; then
    echo "❌ Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Create network if it doesn't exist
echo "📡 Creating Docker network..."
docker network create ai-finance-network 2>/dev/null || echo "Network already exists"

# Check if backend container is running
if ! docker ps | grep -q "goaccounting-api"; then
    echo "⚠️  Warning: Backend container 'goaccounting-api' is not running"
    echo "   Please start your backend container first and connect it to ai-finance-network"
    echo "   Example: docker network connect ai-finance-network goaccounting-api"
fi

# Check for development or production mode
MODE=${1:-dev}

if [ "$MODE" == "dev" ]; then
    echo "🔧 Starting development environment..."
    
    # Stop existing containers
    docker-compose -f docker-compose.prod.yml down 2>/dev/null || true
    
    # Stop existing dev container if running
    docker stop ai-finance-frontend-dev 2>/dev/null || true
    docker rm ai-finance-frontend-dev 2>/dev/null || true
    
    # For development, run container directly without hot reload conflicts
    echo "🏗️ Building development container..."
    
    # Check if Dockerfile exists
    if [ ! -f "Dockerfile" ]; then
        echo "❌ Dockerfile not found. Please ensure Dockerfile exists in the project root."
        exit 1
    fi
    
    # Build with better error handling
    if docker build --build-arg NODE_ENV=development -t ai-finance-frontend:dev . ; then
        echo "✅ Docker image built successfully"
    else
        echo "❌ Docker build failed. Common solutions:"
        echo "   1. Make sure uni-app CLI is installed in Dockerfile:"
        echo "      RUN npm install -g @dcloudio/uni-cli"
        echo "   2. Check if package.json has the correct build script"
        echo "   3. Verify all dependencies are properly installed"
        exit 1
    fi
    
    # Run development container
    if docker run -d \
        --name ai-finance-frontend-dev \
        --network ai-finance-network \
        -p 8080:80 \
        -e NODE_ENV=development \
        ai-finance-frontend:dev ; then
        
        echo "✅ Development environment started!"
        echo "🌐 Frontend (Dev): http://localhost:8080"
        echo "📊 To view logs: docker logs -f ai-finance-frontend-dev"
        echo "🛑 To stop: docker stop ai-finance-frontend-dev"
    else
        echo "❌ Failed to start development container"
        echo "📊 Check logs with: docker logs ai-finance-frontend-dev"
        exit 1
    fi
    
elif [ "$MODE" == "prod" ]; then
    echo "🏗️ Starting production environment..."
    
    # Stop existing containers
    docker-compose -f docker-compose.prod.yml down
    
    # Start production service with error handling
    if docker-compose -f docker-compose.prod.yml up -d --build ; then
        echo "✅ Production environment started!"
        echo "🌐 Frontend (Production): http://localhost:80"
        echo "📊 To view logs: docker-compose -f docker-compose.prod.yml logs -f"
        echo "🛑 To stop: docker-compose -f docker-compose.prod.yml down"
    else
        echo "❌ Production deployment failed"
        echo "📊 Check logs with: docker-compose -f docker-compose.prod.yml logs"
        exit 1
    fi
    
else
    echo "Usage: $0 [dev|prod]"
    echo "  dev  - Start development environment"
    echo "  prod - Start production environment"
    exit 1
fi

# Wait for services to be ready
echo "⏳ Waiting for services to be ready..."
sleep 10

# Check if services are running
if [ "$MODE" == "dev" ]; then
    if docker ps | grep -q "ai-finance-frontend-dev"; then
        echo "✅ Development deployment successful!"
    else
        echo "❌ Development deployment failed. Check logs with: docker logs ai-finance-frontend-dev"
        exit 1
    fi
else
    if docker-compose -f docker-compose.prod.yml ps | grep -q "Up"; then
        echo "✅ Production deployment successful!"
    else
        echo "❌ Production deployment failed. Check logs with: docker-compose -f docker-compose.prod.yml logs"
        exit 1
    fi
fi

echo ""
echo "🔧 Network Configuration:"
echo "   - Frontend can access backend via: http://goaccounting-api:8080"
echo "   - API calls from frontend: /api/* → backend"
echo "   - Make sure backend container is in ai-finance-network"
echo ""
echo "🛠️ Troubleshooting:"
echo "   - If build fails, check your Dockerfile"
echo "   - Ensure uni-app CLI is installed: npm install -g @dcloudio/uni-cli"
echo "   - Verify package.json has correct build scripts"
