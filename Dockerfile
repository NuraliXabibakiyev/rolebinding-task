FROM alpine

RUN apk add --no-cache curl

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl" && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl.sha256" && \
    echo "$(cat kubectl.sha256)  kubectl" | sha256sum -c && \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin/

COPY service-account-config /config/log-reader-config

ENV KUBECONFIG="/config/log-reader-config"

CMD ["/bin/sh"]
