
# Lesson 3 - Non-root users (SECURITY FIRST!)

In this lesson we'll take our Dockerfile from lesson 2 and optimize it by running our application as a non-root user. This will help us improve the security of our application.

## Why use non-root users?

Running your application as a non-root user is a best practice in the Docker community. This helps to improve the security of your application by reducing the attack surface. If an attacker gains access to your container, they will only have the permissions of the non-root user.

## Updating our Dockerfile

Let's update our Dockerfile to run our application as a non-root user.

### Step 1

Update our old Dockerfile or create a new one.

Add a new user to the container:

Its important we add this to our "run" stage and not the build one. This is because we want to run our application as a non-root user, not build it.

```Dockerfile
# Add a new user
RUN addgroup -S appgroup && adduser -S nextjs-user -G appgroup
```

This command creates a new group called `appgroup` and a new user called `nextjs-user` and adds the user to the group.

### Step 2

Change the ownership of the working directory to the new user:

```Dockerfile
# Change the ownership of the working directory
RUN chown -R nextjs-user:appgroup /app
```

This command changes the ownership of the `/app` directory to the `nextjs-user` user and `appgroup` group.

### Step 3

When copying files from our build container they will keep their original ownership. We need to change the ownership of these files to the new user:

```Dockerfile
# Change the ownership of the project files
COPY --chown=nextjs-user:appgroup --from=builder /app/.next ./.next
COPY --chown=nextjs-user:appgroup --from=builder /app/public ./public
COPY --chown=nextjs-user:appgroup --from=builder /app/node_modules ./node_modules
COPY --chown=nextjs-user:appgroup --from=builder /app/package.json ./
```

This command changes the ownership of the files that we copy from the build container to the `nextjs-user` user and `appgroup` group.

### Step 4

Switch to the new user:

```Dockerfile
# Switch to the new user
USER nextjs-user
```

This is a Docker command that changes the user that the container runs as.

### Step 5

Build the Dockerfile


### Step 6

Verify it's correct by running a shell in the container and verifying the user:

```bash
docker run -it lesson-3 sh
```

This will start the container and run our "sh" command. This will give us a shell inside the container where we can verify the user.

```bash
ls -la
```

The output should look something like 

```
/app $ ls -la
total 32
drwxr-xr-x    1 nextjs-u appgroup      4096 Apr  3 12:57 .
drwxr-xr-x    1 root     root          4096 Apr  3 12:57 ..
drwxr-xr-x    6 nextjs-u appgroup      4096 Apr  3 12:53 .next
drwxr-xr-x  322 nextjs-u appgroup     12288 Apr  3 12:53 node_modules
-rw-r--r--    1 nextjs-u appgroup       547 Apr  3 08:59 package.json
drwxr-xr-x    2 nextjs-u appgroup      4096 Apr  3 08:59 public
```