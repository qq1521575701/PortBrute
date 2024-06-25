# Step 1: Pull Ubuntu 22.04 image from Docker Hub
FROM ubuntu:22.04

# Step 2: Update the package repository inside the container
RUN apt-get update -y

# Step 3: Install zmap package
RUN apt-get install -y zmap

# Step 4: Copy all files from the current directory to /root in the container
COPY . /root/

WORKDIR /root
