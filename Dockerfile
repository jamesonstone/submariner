# This file is taken from the stackrox demo: https://github.com/stackrox/admission-controller-webhook-demo/blob/main/image/Dockerfile

FROM golang:1.17-alpine as builder

WORKDIR /workspace

COPY go.mod go.mod
COPY go.sum go.sum
COPY ./cmd/webhook-server/main.go .
COPY ./cmd/webhook-server/admission_controller.go .

RUN go mod download

# the entrypoint for the go binary is actually the entire directory because main extends to both main.go and admission_controller.go
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 GO111MODULE=on go build -a -o admisson-control .

CMD [ "/admisson-control" ]
