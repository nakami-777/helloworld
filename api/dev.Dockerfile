# syntax=docker/dockerfile:1
FROM golang:1.22
WORKDIR /app
RUN go install github.com/cosmtrek/air@latest
COPY go.mod go.sum ./
RUN go mod download
ENTRYPOINT [ "air", "-c", ".air.toml" ]
