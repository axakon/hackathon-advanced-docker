
# Lesson 2.5 - Debugging Docker files

In this lesson we'll take our Dockerfile from lesson 2 and debug it using the `docker exec` command.


## Pre-requisites

It's important to understand how Docker layers its images. When you build a Docker image, each command in the Dockerfile creates a new layer. These layers are cached by Docker and can be reused when building the image. This is useful when you're building an image multiple times and only want to rebuild the layers that have changed.

## Example

We'll break our previous Dockerfile by skipping the npm install step and then debug it using the `docker exec` command.

## Step 1

Create a new Dockerfile or update your previous

Remove the `npm install` command from the Dockerfile.

## Step 2

Try to build the Dockerfile
    
```bash
docker build -t lesson-25 -f Dockerfile ../src
```

You'll see this fail

## Step 3

To easily debug this part, we can comment out the remaining steps in the Dockerfile and build it again.

## Step 4

Now we can run our container and debug it using regular shell commands like this:

```bash
docker run -it lesson-25 sh
```

This will start the container and run our "sh" command. This will give us a shell inside the container where we can debug the issue.

