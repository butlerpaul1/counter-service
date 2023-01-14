.PHONY: test

ALL_PACKAGES_EXCL_INTEGRATION=$(shell go list ./... | grep -v -E "integration")

default: help

help:
	@echo 'Make commands for counter-service: '
	@echo
	@echo 'Usage: '
	@echo '    make test          	            Run unit tests'
	@echo '    make clean       	            Remove binaries'
	@echo '    make build       	            Build the project'

TIMEOUT = 20
ALL_PACKAGES = $(shell go list ./... | grep -v -E "vendor")
test: 
	go test -timeout $(TIMEOUT)s -v $(ALL_PACKAGES)

build: BUILD_ARGS = 
build-linux: BUILD_ARGS = GOOS=linux GOARCH=amd64
build build-linux:
	$(BUILD_ARGS) go build -a -o bin/counter-service main.go

clean:
	@test ! -e bin || rm -r bin
