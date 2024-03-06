# 1. Start a deep instance in [![Gitpod](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/TimaxHack/docker-ubuntu)
# Ubuntu with Docker-in-Docker

Before you begin, ensure you have met the following requirements:

- You have a working installation of Docker on your host machine.
- You have basic knowledge of operating Docker and Docker commands.

## Building the Docker Image
To build the custom Ubuntu image that includes the Docker CLI and can connect to the host's Docker daemon, follow these steps:

1. **Prepare your Dockerfile**

    Create a `Dockerfile` with the following content:

    
Dockerfile
    FROM ubuntu:latest

    # Install dependencies, add Docker repository and install Docker CLI
    RUN apt-get update && \
        apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
        apt-get update && \
        apt-get install -y docker-ce-cli

    # Clean up APT cache
    RUN rm -rf /var/lib/apt/lists/*

    CMD ["bash"]
    
    Save this `Dockerfile` in a directory on your host machine.

2. **Build the Image**

    Run the following command on your host to build the Docker image:

```sh
docker build -t my-ubuntu-with-docker .
``` 
## Running the Container with Docker Socket

To run a container from the newly built image with Docker capabilities, use the command:
```sh
docker run -it --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock 
my-ubuntu-with-docker
```
This command mounts the host's Docker socket into the container, allowing you to execute Docker commands inside the container.

## Executing Docker Commands in the Container

Once inside the interactive shell of the container, you can execute Docker commands like:
```sh
docker run hello-world
```

This will run the `hello-world` Docker container using the host's Docker daemon.



