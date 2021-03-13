FROM gitpod/workspace-full

USER root

USER gitpod

SHELL ["/bin/bash", "-c"]
RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "moar"
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "global" "moar-2021.02.1"
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "zef"

ENV PATH /home/gitpod/.rakudobrew/bin:/home/gitpod/.rakudobrew/versions/moar-2021.02.1/install/share/perl6/site/bin:$PATH
RUN zef install --/test cro
