FROM golang
MAINTAINER Ferran Rodenas <frodenas@gmail.com>

# Set environment variables
ENV CGO_ENABLED 0
ENV GOARCH      amd64
ENV GOARM       5
ENV GOOS        linux

# Build BOSH Registry
RUN go get -a -installsuffix cgo -ldflags '-s' github.com/cf-platform-eng/rds-broker

# Add files
ADD Dockerfile.final /go/bin/Dockerfile
ADD config-sample.json /go/bin/config.json
RUN apt-get update && apt-get install -y wget && wget https://get.docker.com/builds/Linux/x86_64/docker-latest -O /usr/bin/docker
RUN chmod u+x /usr/bin/docker
# Command to run
CMD docker build -t cfplatformeng/rds-broker /go/bin
