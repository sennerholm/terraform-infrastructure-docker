# renovate: datasource=docker depName=docker.io/hashicorp/terraform
ARG TERRAFORM_VERSION=1.16.1

FROM docker.io/hashicorp/terraform:${TERRAFORM_VERSION} AS provider-downloader

WORKDIR /tmp/tf-init

RUN cat > providers.tf <<'EOF'
terraform {
  required_providers {
    zitadel = {
      source  = "zitadel/zitadel"
      version = "~> 2.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }
}
EOF

RUN terraform providers mirror /tmp/provider-mirror

FROM docker.io/hashicorp/terraform:${TERRAFORM_VERSION}

COPY --from=provider-downloader /tmp/provider-mirror /usr/local/share/terraform/plugins

RUN mkdir -p /etc/terraform.d && \
    cat > /etc/terraform.d/terraformrc <<'EOF'
provider_installation {
  filesystem_mirror {
    path    = "/usr/local/share/terraform/plugins"
    include = ["zitadel/zitadel", "hashicorp/kubernetes"]
  }
  direct {
    exclude = ["zitadel/zitadel", "hashicorp/kubernetes"]
  }
}
EOF

ENV TF_CLI_CONFIG_FILE=/etc/terraform.d/terraformrc
 
