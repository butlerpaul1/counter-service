FROM golang:1.16-alpine

# Environment variable that our dockerised application can make use of. 
# The value of the http_port arg is set as the env variable.
ARG http_port
ENV PORT=$http_port

# Set destination for COPY
WORKDIR /app

# Download necessary Go modules
COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY *.go ./

# Build
RUN go build -o /bin/counter-service 

# Run
CMD [ "/bin/counter-service" ]
