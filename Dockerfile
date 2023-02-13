# Use an official base image for the latest version of Ubuntu
FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive

# Set the working directory to /app
WORKDIR /app

# Install dependencies 
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    groff \
    less \
    nodejs \
    npm \ 
    python3 && \
    apt-get clean

# Install Node 18.x
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash && \ 
    apt install -y nodejs && \
    apt-get clean

# Download and install the AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install

# Download and install AWS SAM
RUN curl -L "https://github.com/aws/aws-sam-cli/releases/download/v1.73.0/aws-sam-cli-linux-x86_64.zip" -o "aws-sam.zip" && \
    unzip aws-sam.zip -d sam-installation && \
    ./sam-installation/install

# Install AWS SAM and AWS CDK
RUN npm install -g aws-cdk@2.64.0

# Install the Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash

# Set the default command to start the bash shell
CMD ["/bin/bash"]
