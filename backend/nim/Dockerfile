FROM nimlang/nim:1.4.6 AS builder
WORKDIR /bbs-backend/
COPY nim.nimble .
COPY src/ ./src/
RUN nimble build -Y

FROM alpine:latest
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
WORKDIR /app/
COPY --from=builder /bbs-backend/bin/server .
CMD ["/app/server"]
