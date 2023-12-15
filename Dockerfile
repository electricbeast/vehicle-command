FROM golang:1.20 as builder

WORKDIR /vehicle-command

COPY . .

RUN go get ./...

RUN go build ./...

RUN go install ./...


FROM alpine:latest as runner

COPY --from=builder /go/bin/tesla-http-proxy /usr/local/bin/tesla-http-proxy

ENTRYPOINT ["/usr/local/bin/tesla-http-proxy"]
