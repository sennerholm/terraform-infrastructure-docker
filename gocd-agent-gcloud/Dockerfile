FROM gocd/gocd-agent-ubuntu-16.04:v17.9.0
MAINTAINER mikael@sennerholm.net
# Adding Google tools
RUN apt-get -y install sudo lsb-release && \ 
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update && \
    apt-get -y install google-cloud-sdk kubectl && \
    apt-get clean
# Installing terragrunt
RUN cd /tmp && \
    curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.10.5/terraform_0.10.5_linux_amd64.zip && \
    unzip /tmp/terraform.zip && \
    cp /tmp/terraform /usr/local/bin && \
    chmod a+x /usr/local/bin/terraform && \
    rm /tmp/terraform /tmp/terraform.zip
# Installing terraform
RUN cd /tmp && \
    curl -o /tmp/terragrunt -L  https://github.com/gruntwork-io/terragrunt/releases/download/v0.13.2/terragrunt_linux_amd64 && \
    cp /tmp/terragrunt /usr/local/bin && \
    chmod a+x /usr/local/bin/terragrunt && \
    rm /tmp/terragrunt 
ADD pre-docker-entrypoint.sh /

# Add terraform/grunt?

ENTRYPOINT ["/pre-docker-entrypoint.sh"]
