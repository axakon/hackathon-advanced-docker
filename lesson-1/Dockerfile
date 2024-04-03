FROM alpine:latest

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

# Specify the command to run your application
ENTRYPOINT [ "npm", "start" ]

