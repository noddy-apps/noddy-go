FROM golang:1.8

# handle build proxy argument
#
# docker build --build-arg HTTP_PROXY=some-value .
ARG HTTP_PROXY=
RUN export http_proxy=$HTTP_PROXY
RUN export https_proxy=$HTTP_PROXY

# install source and build
WORKDIR /go/src/app
ADD main.go /go/src/app/main.go
RUN go-wrapper download   # "go get -d -v ./..."
RUN go-wrapper install    # "go install -v ./..."

# start app
CMD ["go-wrapper", "run"] # ["app"]

