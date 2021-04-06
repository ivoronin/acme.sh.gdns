ARG BASE_IMAGE=alpine:3.13.4

FROM ${BASE_IMAGE}
RUN apk add acme.sh curl python3 dumb-init docker
RUN curl https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-335.0.0-linux-x86_64.tar.gz | tar xzf -
#RUN /google-cloud-sdk/install.sh
ARG GOCRON_VERSION=0.0.5
RUN curl -L https://github.com/ivoronin/go-cron/releases/download/v${GOCRON_VERSION}/go-cron_${GOCRON_VERSION}_linux_amd64.tar.gz | tar xzf - go-cron
ADD entrypoint.sh /
ADD issue.sh /
RUN chmod +x /entrypoint.sh /issue.sh
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD /entrypoint.sh
