FROM registry.access.redhat.com/ubi9/ubi AS binaries
ENV kubectl_version="v1.28.9"
ENV oc_version="4.15.9"

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/${kubectl_version}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

RUN curl -LO https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${oc_version}/openshift-client-linux.tar.gz && \
    tar xvfz ./openshift-client-linux.tar.gz oc && \
    rm ./openshift-client-linux.tar.gz && \
    mv ./oc /usr/local/bin/oc


FROM ghcr.io/kanisterio/kanister-tools:0.108.0

LABEL org.opencontainers.image.base.name="ghcr.io/kanisterio/kanister-tools" \
      org.opencontainers.image.description="This is NOT an official kanister image. This is an alternative image providing kanister tools and a more recent kubectl version." \
      org.opencontainers.image.source="https://github.com/rokt-cloud/kanister-kubectl-container-image" \
      org.opencontainers.image.title="kanister-kubectl" \
      org.opencontainers.image.version="${kubectl_version}"

COPY --from=binaries /usr/local/bin/* /usr/local/bin/
