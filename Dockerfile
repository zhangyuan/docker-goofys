FROM golang:alpine3.16

RUN apk add git make

WORKDIR /build

RUN git clone git@github.com:kahing/goofys.git && \
  git chekout 829d8e5

RUN make build
