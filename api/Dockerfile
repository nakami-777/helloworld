# syntax=docker/dockerfile:1

FROM golang:1.22

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 go build -o /helloworld

EXPOSE 8080

ENTRYPOINT [ "/helloworld" ]
