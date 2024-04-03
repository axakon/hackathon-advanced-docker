# Stage 1: Build stage
FROM alpine:latest AS builder

# Install Node.js and npm
RUN apk add --update nodejs npm

# Set the working directory
WORKDIR /app

# Copy your application code to the container
COPY . .

# Install dependencies
RUN npm install

# Build your application
RUN npm run build

# Stage 2: Production stage
FROM alpine:latest

# Install Node.js and npm
RUN apk add --update nodejs npm

# Set the working directory
WORKDIR /app

# Add a new user
RUN addgroup -S appgroup && adduser -S nextjs-user -G appgroup

# Change the ownership of the working directory
RUN chown -R nextjs-user:appgroup /app

# Switch to the new user
USER nextjs-user

# Copy the built application from the build stage
COPY --chown=nextjs-user:appgroup --from=builder /app/.next ./.next
COPY --chown=nextjs-user:appgroup --from=builder /app/public ./public
COPY --chown=nextjs-user:appgroup --from=builder /app/node_modules ./node_modules
COPY --chown=nextjs-user:appgroup --from=builder /app/package.json ./

# Specify the command to run your application
CMD ["npm", "start"]
