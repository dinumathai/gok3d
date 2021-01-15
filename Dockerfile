FROM docker:20

# Install all needed package
RUN apk update
RUN apk add --no-cache bash curl sudo git jq make musl-dev go

# Setting the working Directory
RUN export GOPATH=/go
RUN mkdir -p ${GOPATH}/src ${GOPATH}/bin
RUN export PATH=$PATH:$GOPATH/bin
WORKDIR $GOPATH/src

# Install kustomize
RUN curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
RUN mv kustomize /usr/local/bin/
RUN chmod +x /usr/local/bin/kustomize

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Install k3d
RUN curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | TAG=v3.2.0 bash
