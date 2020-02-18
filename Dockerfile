FROM golang:1.13.8-alpine3.11

LABEL VERSION "v0.0.1"
LABEL MAINTAINER "Aurelien PERRIER"

RUN apk add gcc libc-dev

WORKDIR /go/src/github.com/perriea/app-dev
COPY . .

RUN go test
RUN go build -o app-dev

FROM alpine:latest  
RUN apk --no-cache add ca-certificates
WORKDIR /root/
COPY --from=0 /go/src/github.com/perriea/app-dev/app-dev .
CMD ["./app-dev"]  