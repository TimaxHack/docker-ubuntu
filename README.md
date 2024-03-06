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
docker run -it --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock my-ubuntu-with-docker
```
This command mounts the host's Docker socket into the container, allowing you to execute Docker commands inside the container.

## Executing Docker Commands in the Container

Once inside the interactive shell of the container, you can execute Docker commands like:
```sh
docker run hello-world
```

This will run the `hello-world` Docker container using the host's Docker daemon.



/

/

/

/

/

/ не проверенно 

/

/

/

/

/

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
    
## Running the Container with Docker Socket and Volumes

To run a container from the newly built image with Docker capabilities and persistent storage, use the command:
```sh
docker run -it --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v my-volume:/data my-ubuntu-with-docker
```
This command mounts the host's Docker socket into the container and also mounts a persistent volume at `/data` within the container.

## Managing Data with Docker Volumes

Data changes within containers can be persisted across container restarts and even after the container is deleted by using Docker volumes. To manage data using volumes, follow these steps:

1. **Create a Docker Volume**

    This will create a new volume that can be used to store data persistently.

    
```sh
docker volume create my-volume
```

2. **Attach the Volume to the Container**

    When you run your container, use the `-v` option to mount the volume to a path inside the container.

    
```sh
docker run -it --rm --privileged -v /var/run/docker.sock:/var/run/docker.sock -v my-volume:/path/in/container my-ubuntu-with-docker
```    
Replace `/path/in/container` with the actual path where you want the volume to be mounted inside the container.

3. **Save Data to the Volume**

    While working inside the container, save any data or make changes to the `/path/in/container`, and these changes will be written to the volume `my-volume`.

4. **Accessing Data After Container Stop or Deletion**

    Data stored in `my-volume` will remain available to be mounted into other containers. For example, if you stop or delete the container, you can create another one, and mount the same volume to access the data again.

## Executing Docker Commands in the Container

Once inside the interactive shell of the container, you can execute Docker commands like:
sh
docker run hello-world
This will run the `hello-world` Docker container using the host's Docker daemon.

