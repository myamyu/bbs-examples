FROM gitpod/workspace-full

USER root

RUN apt-get install -y perl6 perl6-zef rakudo

USER gitpod
