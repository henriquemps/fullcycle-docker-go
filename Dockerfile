# Build apra descarte
FROM golang:1.19-alpine AS builder

WORKDIR /app

COPY go.mod *.go ./

RUN go mod download && go mod verify
RUN go build -v -o /usr/local/bin/app


# Utilização de imagem "scratch" para binário
FROM scratch

WORKDIR /

COPY --from=builder /usr/local/bin/app /

CMD ["/app"]