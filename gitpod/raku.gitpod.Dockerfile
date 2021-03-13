FROM gitpod/workspace-full

USER root

USER gitpod

RUN git clone https://github.com/tadzik/rakudobrew ~/.rakudobrew
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "moar"
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "global" "moar-2021.02.1"
RUN command ~/.rakudobrew/bin/rakudobrew internal_hooked "build" "zef"

RUN . <(~/.rakudobrew/bin/rakudobrew init Bash -)
RUN zef install --/test cro
