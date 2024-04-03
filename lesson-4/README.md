
# Lesson 4 - Using our Dockerfile in Docker Compose

In this lesson we'll take our Dockerfile from lesson 3 and use it in a Docker Compose setup. This is useful in a local development environment where you might want to run parts of your system locally but not rely on registry images.


## Building images with Docker compose

### Step 1

Create a new file called `docker-compose.yml` in the root of your project.

```yaml
version: '3.8'

services:
  app:
    build:
      context: ../src
      dockerfile: ../lesson-4/Dockerfile
    ports:
      - "3000:3000"
```

This sets up a new service called `app` that builds the Dockerfile from lesson 3 and maps port 3000 on the host to port 3000 on the container.

It's worth noting that the build context doesn't behave the same way as the `docker build` command. The "Dockerfile" path is relative to the build context, so we need to specify the path to the Dockerfile in the `dockerfile` key relative to the context specified in the `context` key.

### Step 2

Run the Docker Compose command to build the image and start the container.

```bash
docker-compose up
```
