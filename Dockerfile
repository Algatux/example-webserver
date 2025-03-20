# Costruzione del binario Go
FROM golang:1.24 AS builder
WORKDIR /app
COPY . .
RUN go mod tidy
RUN go build -o server .

# Creazione dell'immagine finale con distroless
FROM gcr.io/distroless/base-debian12
WORKDIR /
COPY --from=builder /app/server .
CMD ["/server"]
EXPOSE 8080