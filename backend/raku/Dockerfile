FROM croservices/cro-http:0.8.4
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN zef install --deps-only . && raku -c -Ilib service.raku
ENV BBS_HOST="0.0.0.0" BBS_PORT="10000"
EXPOSE 10000
CMD raku -Ilib service.raku
