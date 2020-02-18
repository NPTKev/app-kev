FROM golang:1.13.8-alpine3.11

LABEL VERSION "v0.0.1"
LABEL MAINTAINER "Aurelien PERRIER"
ENV GO111MODULE on

# Install gcc and stdin libs
RUN apk add gcc libc-dev

# Copy code in the container
WORKDIR /go/src/github.com/perriea/app-dev
COPY . .

# Golang test units
RUN go test
# Build binary
RUN go build -o app-dev

FROM alpine:latest

# Label to identify the maintainer
LABEL VERSION "v0.0.1"
LABEL MAINTAINER "Aurelien PERRIER"

# Adding user to 
RUN apk --no-cache add ca-certificates
RUN adduser kevin --home /home/kevin --disabled-password

# Copy binary on the last stage
WORKDIR /home/kevin
COPY --from=0 /go/src/github.com/perriea/app-dev/index.html .
COPY --from=0 /go/src/github.com/perriea/app-dev/app-dev .

# Assign kevin user
USER kevin

CMD ["./app-dev"]  