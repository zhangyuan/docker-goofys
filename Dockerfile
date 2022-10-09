FROM golang:alpine3.16 as builder

RUN apk add git make

WORKDIR /build

RUN git clone https://github.com/kahing/goofys && \
  cd goofys && git chekout 829d8e5

RUN make build

FROM alpine:3.16.2
RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

RUN apk add --no-cache tini

ARG USER=default
ENV HOME /home/$USER
RUN adduser -D $USER

COPY --from=builder /build/goofys/goofys /usr/local/bin/

USER $USER
WORKDIR $HOME

ENTRYPOINT ["/sbin/tini", "--"]
