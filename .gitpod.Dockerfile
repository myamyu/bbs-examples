FROM gitpod/workspace-full

USER root

RUN apt update && apt install -y curl xz-utils g++ git

USER gitpod

SHELL ["/bin/bash", "-c"]

# nim
RUN curl https://nim-lang.org/choosenim/init.sh -sSf | bash -s -- -y
ENV PATH=/home/gitpod/.nimble/bin:$PATH

# raku
ENV MOARVER 2021.05
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew \
    && command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "moar" "${MOARVER}" \
    && command ~/.rakudobrew/bin/rakudobrew internal_hooked "global" "moar-${MOARVER}" \
    && command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "zef"
ENV PATH /home/gitpod/.rakudobrew/bin:$PATH
ENV PATH /home/gitpod/.rakudobrew/versions/moar-${MOARVER}/install/share/perl6/site/bin:$PATH
ENV PATH /home/gitpod/.rakudobrew/versions/moar-${MOARVER}/install/bin:$PATH
RUN zef install --/test cro
