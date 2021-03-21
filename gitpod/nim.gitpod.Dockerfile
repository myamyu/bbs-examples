FROM gitpod/workspace-full

USER root

RUN apt update && apt install -y curl xz-utils g++ git

USER gitpod

SHELL ["/bin/bash", "-c"]

RUN curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
ENV PATH=/gitpod/.nimble/bin:$PATH
