MODULE_NAME := $(shell go list -m)

.DEFAULT_GOAL := test

.PHONY: fmt vet test clean

fmt: 
	@echo "Running go fmt..."
	@go fmt ./...

test: ## run the tests
	@echo "Running tests..."
	@go test -coverprofile=coverage.out ./... 

vet: fmt ## fmt, vet, and staticcheck
	@echo "Running go vet and staticcheck..."
	@go vet ./...
	@staticcheck ./...

cognitive: ## run the cognitive complexity checker
	@echo "Running gocognit..."
	@gocognit  -ignore "_test|testdata" -top 5 .

help: ## show this help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
