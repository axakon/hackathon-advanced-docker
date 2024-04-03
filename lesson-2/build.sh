#!/bin/bash

# This is a bit of a "hax" but since every lesson is relying on src I don't want to have to copy it every time, so we move the context to the src folder and then reference the Dockerfile
docker build -t lesson-2 -f Dockerfile ../src