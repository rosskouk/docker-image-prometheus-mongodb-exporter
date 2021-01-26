FROM golang:latest as build
RUN go get -u -v github.com/percona/mongodb_exporter
WORKDIR /go/src/github.com/percona/mongodb_exporter
RUN make build

FROM alpine:3.12.3
COPY --from=build /go/src/github.com/percona/mongodb_exporter/bin/mongodb_exporter /usr/local/bin/mongodb_exporter
EXPOSE 9118
ENTRYPOINT ["mongodb_exporter"]
CMD ["--web.listen-address=:9122"]