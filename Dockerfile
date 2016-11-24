FROM golang:1.7-alpine

WORKDIR /go/src/app

COPY . /go/src/app

RUN \
	apk add --no-cache git && \
	go-wrapper download && \
	go-wrapper install -ldflags "-X github.com/minio/minio/cmd.Version=2016-11-24T02:09:08Z -X github.com/minio/minio/cmd.ReleaseTag=RELEASE.2016-11-24T02-09-08Z -X github.com/minio/minio/cmd.CommitID=0e87f29de9a022d3618e2e84e54c34e2338b4b6a" && \
	mkdir -p /export/docker && \
	cp /go/src/app/docs/docker/README.md /export/docker/ && \
	rm -rf /go/pkg /go/src && \
	apk del git

EXPOSE 9000
ENTRYPOINT ["minio"]
VOLUME ["/export"]
