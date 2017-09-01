FROM gocd/gocd-server:v17.8.0
MAINTAINER mikael@sennerholm.net

ADD pre-docker-entrypoint.sh /

# Workaround before 17.9.0 and sending logs to stdout is released
# https://github.com/gocd/docker-gocd-server/commit/47fc5c55bdd6116e5d51f57ecd65036733a2b684
RUN sed -i -e 's/\(log4j.rootLogger.*\)/\1, stdout/g' /go-server/config/log4j.properties && \
    echo "" >> /go-server/config/log4j.properties && \
    echo "" >> /go-server/config/log4j.properties && \
    echo "# Log to stdout" >> /go-server/config/log4j.properties && \
    echo "log4j.appender.stdout=org.apache.log4j.ConsoleAppender" >> /go-server/config/log4j.properties && \
    echo "log4j.appender.stdout.layout=org.apache.log4j.PatternLayout" >> /go-server/config/log4j.properties && \
    echo "log4j.appender.stdout.layout.conversionPattern=%d{ISO8601} %5p [%t] %c{1}:%L - %m%n" >> /go-server/config/log4j.properties
ADD docker-entrypoint.sh /
# End of workaround

ENTRYPOINT ["/pre-docker-entrypoint.sh"]
