# renovate: datasource=docker depName=ghcr.io/coder/coder
ARG CODER_VERSION=v2.37.0

FROM ghcr.io/coder/coder:${CODER_VERSION} AS provider-downloader

USER root
WORKDIR /tmp/tf-init

RUN cat > providers.tf <<'EOF'
terraform {
  required_providers {
    coder = {
      source  = "coder/coder"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}
EOF

RUN terraform providers mirror -platform=linux_amd64 /tmp/provider-mirror

FROM ghcr.io/coder/coder:${CODER_VERSION}

USER root

COPY --from=provider-downloader /tmp/provider-mirror /home/coder/.terraform.d/plugins

RUN mkdir -p /home/coder/.terraform.d && \
    cat > /home/coder/.terraformrc <<'EOF'
provider_installation {
  filesystem_mirror {
    path = "/home/coder/.terraform.d/plugins"
  }
}
EOF

RUN chown -R coder:coder /home/coder/.terraform.d /home/coder/.terraformrc

USER coder

ENV TF_CLI_CONFIG_FILE=/home/coder/.terraformrc
# Disable outbound connections not needed in airgapped environments
ENV CODER_TELEMETRY_ENABLE=false
ENV CODER_UPDATE_CHECK=false
ENV CODER_DERP_SERVER_STUN_ADDRESSES=disable
