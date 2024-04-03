
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

### Additional info

 - version: '3.8': Specifies the version of Docker Compose file syntax being used. This version introduces features and syntax changes specific to Docker Compose.

 - services: Defines the services that make up your application's containers.

 - app: The name of the service being defined. In this case, it's an arbitrary name for the application service. Other examples could be `database` for a MySQL or MongoDB database, or `cache` for a Redis cache.

 - image: The Docker image to use for this specific service. If a `build` context is supplied, this is the name and tag that will be used for the finished image, once bulit. If no `build` context is supplied, Docker will try and pull the defined image from the default DockerHub registry.

 - container_name: If you want to give the resulting container a user friendly name, put it here. Defaults to the service name otherwise.

 - build: Specifies how to build the Docker image for the service.

   - context: Defines the build context, which is the location from which Docker will build the image. It can be a directory or a Git repository URL. Docker will use this context to locate the Dockerfile and any other files required during the build process.

   - dockerfile: Specifies the path to the Dockerfile within the build context. It allows specifying a different Dockerfile other than the default Dockerfile if needed.

 - ports: Specifies port mapping between the host and the container.
   
    - "3000:3000": Maps port 3000 on the host to port 3000 on the container. The format is host_port:container_port.

By defining these settings in the Docker Compose file, you can build and run your application using a single command (docker-compose up) instead of multiple docker commands. This simplifies the process, especially in a development environment.
