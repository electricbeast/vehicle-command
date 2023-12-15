FROM golang:1.20 as builder

WORKDIR /vehicle-command

COPY . .

RUN go get ./...

RUN go build ./...

RUN go install ./...


FROM debian:12 as runner

COPY --from=builder /go/bin/tesla-http-proxy /usr/local/bin/tesla-http-proxy

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/tesla-http-proxy"]
