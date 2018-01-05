# consignment-service

FROM golang:1.9.2 as builder
WORKDIR /go/src/github.com/jakebjorke/shipper-consignment-service
COPY . .

RUN go get
RUN CGO_ENABLED=0 GOOS=linux go build  -o consignment-service -a -installsuffix cgo main.go repository.go handler.go datastore.go

FROM alpine:latest

RUN apk --no-cache add ca-certificates
RUN mkdir /app
WORKDIR /app
COPY --from=builder /go/src/github.com/jakebjorke/shipper-consignment-service/consignment-service .

CMD [ "./consignment-service" ]
