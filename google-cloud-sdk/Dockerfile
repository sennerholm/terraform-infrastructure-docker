FROM google/cloud-sdk:183.0.0
MAINTAINER mikael@sennerholm.net
# Installing terraform
RUN apt-get -y install unzip && \
    cd /tmp && \
    curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip && \
    unzip /tmp/terraform.zip && \
    cp /tmp/terraform /usr/local/bin && \
    chmod a+x /usr/local/bin/terraform && \
    apt-get -y remove unzip && \
    apt-get clean && \
    rm /tmp/terraform /tmp/terraform.zip
# Installing terragrunt
RUN cd /tmp && \
    curl -o /tmp/terragrunt -L  https://github.com/gruntwork-io/terragrunt/releases/download/v0.13.25/terragrunt_linux_amd64 && \
    cp /tmp/terragrunt /usr/local/bin && \
    chmod a+x /usr/local/bin/terragrunt && \
    rm /tmp/terragrunt 
# Installing Docker
RUN    curl -L -o /tmp/docker.tgz https://get.docker.com/builds/Linux/x86_64/docker-17.03.1-ce.tgz && \
  tar -xz -C /tmp -f /tmp/docker.tgz && \
  mv /tmp/docker/* /usr/bin