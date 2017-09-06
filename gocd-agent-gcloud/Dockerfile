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

ADD pre-docker-entrypoint.sh /


ENTRYPOINT ["/pre-docker-entrypoint.sh"]
