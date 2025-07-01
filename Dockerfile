# Multi-stage build for uni-app H5
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Install Vue CLI globally
RUN npm install -g @vue/cli

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code
COPY . .

# Build the uni-app for H5
RUN npm run build:h5

# Check if build was successful and show structure
RUN ls -la /app/unpackage/dist/dev/h5/ || echo "No unpackage/dist/dev/h5 folder found"

# Production stage
FROM nginx:alpine

# Copy custom nginx config (correct path for uni-app H5)
COPY nginx.conf /etc/nginx/nginx.conf

# Copy built files - uni-app H5 typically builds to /app/unpackage/dist/dev/h5/
COPY --from=builder /app/unpackage/dist/dev/h5 /usr/share/nginx/html

# Expose port
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
