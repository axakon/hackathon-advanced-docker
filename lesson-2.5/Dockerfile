# Stage 1: Build stage
FROM alpine:latest AS builder

# Install Node.js and npm
RUN apk add --update nodejs npm

# Set the working directory
WORKDIR /app

# Copy your application code to the container
COPY . .

# Install dependencies
# RUN npm install

# Build your application
# RUN npm run build

# # Stage 2: Production stage
# FROM alpine:latest

# # Install Node.js and npm
# RUN apk add --update nodejs npm

# # Set the working directory
# WORKDIR /app

# # Copy the built application from the build stage
# COPY --from=builder /app/.next ./.next
# COPY --from=builder /app/public ./public
# COPY --from=builder /app/node_modules ./node_modules
# COPY --from=builder /app/package.json ./

# # Specify the command to run your application
# CMD ["npm", "start"]
