FROM gocd/gocd-agent-ubuntu-16.04:v17.8.0
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

# Workaround before 17.9.0 and sending logs to stdout is released
# https://github.com/gocd/docker-gocd-agent/commit/2b7c7c24af0265849b36057f2535e2244d1ed46e
RUN for log_properties_file in agent-bootstrapper-log4j.properties agent-launcher-log4j.properties agent-log4j.properties ;  do \ 
    sed -i -e 's/\(log4j.rootLogger.*\)/\1,stdout/g' /go-agent/config/${log_properties_file}  ;\
    sed -i -e 's/\(log4j.rootCategory.*\)/\1,stdout/g' /go-agent/config/${log_properties_file} ;\
    echo "" >> /go-agent/config/${log_properties_file} ;\
    echo "" >> /go-agent/config/${log_properties_file} ;\
    echo "# Log to stdout" >> /go-agent/config/${log_properties_file} ;\
    echo "log4j.appender.stdout=org.apache.log4j.ConsoleAppender" >> /go-agent/config/${log_properties_file} ;\
    echo "log4j.appender.stdout.layout=org.apache.log4j.PatternLayout" >> /go-agent/config/${log_properties_file} ;\
    echo "log4j.appender.stdout.layout.conversionPattern=%d{ISO8601} %5p [%t] %c{1}:%L - %m%n" >> /go-agent/config/${log_properties_file}  ;\
  done
ADD docker-entrypoint.sh /
# End of workaround

ENTRYPOINT ["/pre-docker-entrypoint.sh"]
