
# Lesson 5 - Networks in Docker Compose

In this lesson we'll take our Docker Compose setup from lesson 4 and add a network to it. This is useful when you have multiple services that need to communicate with each other but also prevent other services from accessing them.

## Why use networks?

When you have multiple services that need to communicate with each other, you can use networks to isolate them from each other. This is useful when you have services that should not be accessible from the outside world.


## Updating our Docker Compose setup

Let's update our Docker Compose setup to use networks.

### Step 1

Update our old Docker Compose setup or create a new one.

Add a new network to the Docker Compose setup:

```yaml
# Create a new network
networks:
  my-network:
    driver: bridge
```

This creates a new network called `my-network` with the `bridge` driver. The `bridge` driver is the default driver for Docker networks and is used to create a network that is isolated from the host (your local computer) network.

### Step 2

Add the network to the service that needs to communicate with other services:

```yaml
services:
  app:
    build:
      context: ../src
      dockerfile: ../lesson-4/Dockerfile
    ports:
      - "3000:3000"
    networks:
      - my-network
```

This adds the `my-network` network to the `app` service. This means that the `app` service can communicate with other services that are also connected to the `my-network` network.

### Step 3

Add another service that uses the same network:

```yaml
nginx:
    image: nginx:alpine
    ports:
        - "8080:80"
    networks:
        - my-network
    volumes:
        - ./nginx.conf:/etc/nginx/nginx.conf
```

You can find the nginx conf inside this lessons folder.

This adds a new service called `nginx` that uses the `my-network` network. This means that the `nginx` service can communicate with the `app` service.

### Step 4

Since we now have a proxy in front our application we no longer need to expose the port in the `app` service:

```yaml
services:
  app:
    build:
      context: ../src
      dockerfile: ../lesson-4/Dockerfile
    networks:
      - my-network
```

This removes the port mapping from the `app` service. This means that the `app` service is no longer directly accessible from the outside world.

### Step 5

Run the compose setup

```bash
docker-compose up
```

This will start the Docker Compose setup and create the `my-network` network. The `app` and `nginx` services will be connected to the `my-network` network and will be able to communicate with each other.

You should be able to see our application running on `http://localhost:8080` now.
