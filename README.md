
# Hackathon - Advanced Docker usage

The goal of this hackathon is to get you familiar with some advanced Docker features and best practices.

We'll start off by building a Docker image from scratch, and then we'll move on to more advanced topics like multi-stage builds, non-root users building and in the end we'll tie it all together with a NextJS deployment.

## Lesson 1 - Building your own Dockerfile (CALL ME BOB THE BUILDER)

In this lesson we'll take our NextJS application and build a Docker image from scratch. The goal is that we'll have a portable image that we can run anywhere.

Checkout the lesson here [Lesson 1](./lesson-1/README.md)

## Lesson 2 - Multi-stage builds (OHH SAVE DAT DISK!)

In this lesson we'll take our Dockerfile from lesson 1 and optimize it using multi-stage builds. This will help us reduce the size of our image and make it more efficient.

Checkout the lesson here [Lesson 2](./lesson-2/README.md)

## Lesson 2.5 - Debugging Docker files

In this lesson we'll take our Dockerfile from lesson 2 and debug it using the `docker build` command. This will help us understand how Docker builds our images and how we can optimize our Dockerfile.

Checkout the lesson here [Lesson 2.5](./lesson-2.5/README.md)

## Lesson 3 - Non-root users (SECURITY FIRST!)

In this lesson we'll take our Dockerfile from lesson 2 and optimize it by running our application as a non-root user. This will help us improve the security of our application.

Checkout the lesson here [Lesson 3](./lesson-3/README.md)


## Lesson 4 - Using our Dockerfile in Docker Compose

In this lesson we'll take our Dockerfile from lesson 3 and use it in a Docker Compose setup. This is useful in a local development environment where you might want to run parts of your system locally but not rely on registry images.

Checkout the lesson here [Lesson 4](./lesson-4/README.md)

## Lesson 5 - Networks in Docker Compose

In this lesson we'll take our Docker Compose setup from lesson 4 and add a network to it. This is useful when you have multiple services that need to communicate with each other but also prevent other services from accessing them.

Checkout the lesson here [Lesson 5](./lesson-5/README.md)
