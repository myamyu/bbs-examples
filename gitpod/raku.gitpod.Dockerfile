FROM gitpod/workspace-full

USER gitpod

RUN sudo apt-get install build-essential git libssl-dev
RUN mkdir ~/rakudo && cd $_
RUN curl -LJO https://rakudo.org/latest/star/src
RUN tar -xzf rakudo-star-*.tar.gz
RUN mv rakudo-star-*/* .
RUN rm -fr rakudo-star-*
RUN perl Configure.pl --backend=moar --gen-moar
RUN make
RUN make rakudo-test
RUN make rakudo-spectest
RUN make install
RUN echo "export PATH=$(pwd)/install/bin/:$(pwd)/install/share/perl6/site/bin:\$PATH" >> ~/.bashrc
RUN source ~/.bashrc
