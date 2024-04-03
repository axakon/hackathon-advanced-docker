# Lesson 2 - Multi-stage builds (OHH SAVE DAT DISK!)

In this lesson we'll take our Dockerfile from lesson 1 and optimize it using multi-stage builds. This will help us reduce the size of our image and make it more efficient.

## What are multi-stage builds?

Multi-stage builds are a feature of Docker that allow you to use multiple `FROM` statements in your Dockerfile. This allows you to build your application in one stage and then copy the artifacts to another stage. This is useful when you want to build your application in one stage and then run it in another stage.

## Why use multi-stage builds?

Multi-stage builds are useful when you want to reduce the size of your image. By building your application in one stage and then copying the artifacts to another stage you can reduce the size of your image. Example you might build your application in an environment that includes the SDK and then copy the artifacts to a smaller environment that only includes the runtime.

## Updating our Dockerfile

Let's update our Dockerfile to use multi-stage builds.

### Step 1

Update our old Dockerfile or create a new one.

Update the first line and tag it with an name so we can grab that output in another stage.

```Dockerfile
FROM alpine:latest AS builder
```

This "tags" this stage as builder, we can then add another FROM stage later on and reference this stage to copy the output from it.

### Step 2

Copy the build artifacts from the builder stage to the final stage.

Within the same file, add
```Dockerfile
# Stage 2: Production stage
FROM alpine:latest

# Install Node.js and npm
RUN apk add --update nodejs npm

# Set the working directory
WORKDIR /app

# Copy the built application from the build stage
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

# Specify the command to run your application
CMD ["npm", "start"]
```

This creates a new stage where we install the neccssary runtimes for our project and copy only the build artifacts from the builder stage.

### Step 3

Build the Dockerfile

```bash
docker build -t lesson-2 -f Dockerfile ../src
```

### Step 4

Compare our new file with the old, you can check the image size by writing

```
docker image ls lesson-1
docker image ls lesson-2
```

This will show you the size difference between the two images.




