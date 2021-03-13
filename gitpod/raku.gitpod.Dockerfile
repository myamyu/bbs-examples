FROM gitpod/workspace-full

USER root

RUN apt update -y
RUN apt install -y rakudo perl6-zef

USER gitpod
