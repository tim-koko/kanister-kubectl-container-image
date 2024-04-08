FROM ghcr.io/kanisterio/kanister-tools:0.107.0
ENV kubectl_version="v1.27.11"

LABEL org.opencontainers.image.base.name="ghcr.io/kanisterio/kanister-tools:0.105.0" \
      org.opencontainers.image.description="This is NOT an official kanister image. This is an alternative image providing kanister tools and a more recent kubectl version." \
      org.opencontainers.image.source="https://github.com/rokt-cloud/kanister-kubectl-container-image" \
      org.opencontainers.image.title="kanister-kubectl" \
      org.opencontainers.image.version="${kubectl_version}"

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${kubectl_version}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl
