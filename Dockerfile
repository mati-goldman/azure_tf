FROM alpine:3.18.4

ARG TF_VERSION=1.6.1

RUN apk --no-cache add --virtual build_deps gettext bash jq wget

RUN wget https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip && \
    chmod +x terraform && \
    mv terraform /usr/local/bin && \
    rm terraform_${TF_VERSION}_linux_amd64.zip

COPY . /azure_images
RUN chmod +x -R /azure_images
WORKDIR /azure_images/cli
