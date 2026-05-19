# Use Node.js 18
FROM node:18

# Set working directory
WORKDIR /app

# Copy package files first to leverage Docker cache layers
COPY package.json package-lock.json ./

# Combine installation to ensure npm resolves the dependency tree perfectly
# We explicitly append chokidar to guarantee it is present in node_modules
RUN npm install && \
    npm install postcss@8.4.21 postcss-safe-parser@6.0.0 chokidar@3.6.0 --legacy-peer-deps

# Copy the entire project
COPY . .

# Expose port 3000
EXPOSE 3000

# Set environment variables
ENV NODE_OPTIONS=--openssl-legacy-provider
ENV PORT=3000
# This prevents chokidar from aggressively consuming CPU inside a container
ENV CHOKIDAR_USEPOLLING=true

# Start the application
CMD ["npm", "start"]
