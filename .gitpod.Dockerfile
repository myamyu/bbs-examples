FROM gitpod/workspace-full

USER root

RUN apt update && apt install -y curl xz-utils g++ git

USER gitpod

SHELL ["/bin/bash", "-c"]

# nim
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
ENV PATH=/home/gitpod/.nimble/bin:$PATH

# raku
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "moar"
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "global" "moar-2021.02.1"
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "zef"
ENV PATH /home/gitpod/.rakudobrew/bin:$PATH
ENV PATH /home/gitpod/.rakudobrew/versions/moar-2021.02.1/install/share/perl6/site/bin:$PATH
ENV PATH /home/gitpod/.rakudobrew/versions/moar-2021.02.1/install/bin:$PATH
RUN zef install --/test cro
