FROM gitpod/workspace-full

USER root

RUN apt-get install build-essential git libssl-dev
RUN apt-get install perl6 perl6-zef rakudo

USER gitpod
