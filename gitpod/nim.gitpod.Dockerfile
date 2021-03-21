FROM gitpod/workspace-full

USER root

RUN apt update && apt install -y curl xz-utils g++ git
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
ENV PATH=/root/.nimble/bin:$PATH

USER gitpod

SHELL ["/bin/bash", "-c"]
