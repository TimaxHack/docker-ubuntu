FROM ubuntu:latest

# Установка зависимостей, добавление репозитория Docker и установка Docker
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Чистка кэша APT 
RUN rm -rf /var/lib/apt/lists/*

CMD ["bash"]
