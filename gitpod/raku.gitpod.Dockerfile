FROM gitpod/workspace-full

USER root

RUN apt update -y
RUN apt install -y rakudo

USER gitpod
