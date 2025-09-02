# Multi-stage Dockerfile for a Next.js app

# 1) Builder: install deps and build the app
FROM node:20-slim AS builder
WORKDIR /app

# Copy only package manifests first for better caching
COPY package*.json ./

# Install all dependencies (including dev) for build
RUN npm ci

# Copy source and build
COPY . .
RUN npm run build

# Remove dev dependencies to keep only production deps
RUN npm prune --production

EXPOSE 3000

# Start the Next.js production server
CMD ["npm", "start"]
