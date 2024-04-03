
# Lesson 1 - Creating your own Dockerfile

Writing Dockerfile's usually start from a base image that in the majority of cases is a Linux based image. In this lesson we will create a simple Dockerfile that will use the Alpine distribution as a base image.


## How a Dockerfile is structured

A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using `docker build` users can create an automated build that executes several command-line instructions in succession.

A Dockerfile adheres to a specific format and set of instructions which you can find at the [official Dockerfile reference](https://docs.docker.com/engine/reference/builder/).

The most used commands are:
1. `FROM` - Sets the base image for the subsequent instructions.
2. `RUN` - Executes a command, treat this as basic shell commands, can run things like apt, apk, yum, etc.
3. `COPY` - Copies files from the build context to the container. We use this command to copy our project files into the container
4. `WORKDIR` - Sets the working directory for the subsequent instructions. This is where all your commands will be executed, example setting the workdir to : `/app` will make sure all commands are executed in the `/app` directory of the container. It will automatically create any missing folders required and then move to that folder.
5. `CMD` - This is the command that will be executed when the container starts. It is important to note that only the last `CMD` instruction in the Dockerfile will have an effect.
6. `ENTRYPOINT` - This is the command that will be executed when the container starts. It is important to note that only the last `ENTRYPOINT` instruction in the Dockerfile will have an effect.

## CMD vs ENTRYPOINT

For the sake of this lesson, always use ENTRYPOINT. CMD is intended for base image maintainers to set the default command, and ENTRYPOINT is intended to be the default command for the container.


## Our first Dockerfile

In this lesson we've created a Dockerfile that installs NodeJS and NPM on an Alpine image.
We then copy our entire NextJS project into our container and install the dependencies and build the project.

**Disclaimer! The copy command is assumes our project exists in the same directory as the Dockerfile. To handle this scenario we move the "context" when building to our projects directory. This is ONLY because we have multiple Dockerfiles in our lessons that reference the same project. In a normal project the Dockerfile would be located next to your code.**



## Building the Dockerfile

### Step 1

Create a new file called `Dockerfile` in the root of your project.
This "Dockerfile" name is just a convention, you can name it whatever you want.
However, if you name it `Dockerfile`, the CLI will automatically pick it up when you run `docker build .`

### Step 2

Decide on a base image:

In this lesson we will use the Alpine image as our base image. The Alpine image is a very small Linux distribution that is very popular in the Docker community.

```Dockerfile
FROM alpine:latest
```

This sets up our base alpine distribution with `apk` as the package manager.

In a "real world" you probable would want to use a more specific base image like `node:14-alpine` or `node:14-slim` to get a more specific version of NodeJS pre-installed.

However for this lesson we're building these images from scratch.

### Step 3

Install NodeJS and NPM

```Dockerfile
RUN apk add --no-cache nodejs npm
```

This command installs NodeJS and NPM on our Alpine image.

### Step 4

Set the working directory

```Dockerfile
WORKDIR /app
```

This command sets the working directory to `/app` in the container.

### Step 5

Copy the project files into the container

```Dockerfile
COPY . .
```

This command copies all the files from the build context into working directory of the container.

### Step 6

Install the project dependencies

```Dockerfile
RUN npm install
```

This command installs all the dependencies of the project.

### Step 7

Build the project

```Dockerfile
RUN npm run build
```

This command builds the project.

### Step 8

Set the entrypoint

The entrypoint is the command that will be executed when the container starts. eg. when you run `docker run <image>` this is the command that will be executed.

```Dockerfile
ENTRYPOINT ["npm", "start"]
```



### Step 9

Build the Dockerfile

#### Example
```bash
docker build -t my-nextjs-app .
```

This command builds the Dockerfile in the current directory and tags the image with the name `my-nextjs-app`.

The `-t` flag is used to tag the image with a name.
The . at the end of the command is the build context. This is the context sent to the Docker daemon when building the image. This is where the Dockerfile is located and where the files are copied from.


#### Caveat

In our lessons we're using the same application for all our Dockerfiles, so we'll need to modify the build command slightly to move the context to the project directory.

**With your current directory as "lesson-1"**
```bash
docker build -t lesson-1 -f Dockerfile ../src
```

NOTE! If you move the context you need to manually specify the Dockerfile with the `-f` flag. Otherwise it will try to read the Dockerfile from the context you specified.

### Step 10

Run the Docker container

```bash
docker run --rm -i -p 3000:3000 lesson-1
```

This command runs the Docker container and maps port 3000 on the host to port 3000 on the container.




