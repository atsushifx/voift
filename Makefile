# @(#) : Makefile for voift CLI
#
# Copyright (c) 2026- atsushifx <http://github.com/atsushifx>
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT


APP := voift
CMD := ./cmd/voift

GO := go
GOBUILD := $(GO) build
GOTEST := $(GO) test
GOFMT := $(GO) fmt

BIN_DIR := bin

LDFLAGS := -s -w


.PHONY: help
help:
	@echo "Available targets:"
	@echo "  make build           Build CLI"
	@echo "  make run             Run CLI"
	@echo "  make install         Install CLI with go install"
	@echo "  make test            Run tests"
	@echo "  make lint            Run golangci-lint"
	@echo "  make fmt             Format source"
	@echo "  make clean           Remove build artifacts"
	@echo "  make build-linux     Cross build Linux"
	@echo "  make build-darwin    Cross build macOS"
	@echo "  make build-windows   Cross build Windows"
	@echo "  make build-all       Cross build all targets"
	@echo "  make release-check   Test goreleaser build"


.PHONY: build
build:
	$(GOBUILD) -ldflags "$(LDFLAGS)" -o $(BIN_DIR)/$(APP) $(CMD)


.PHONY: run
run:
	$(GO) run $(CMD)


.PHONY: install
install:
	$(GO) install $(CMD)


.PHONY: test
test:
	$(GOTEST) ./...


.PHONY: lint
lint:
	golangci-lint run


.PHONY: fmt
fmt:
	$(GOFMT) ./...


.PHONY: clean
clean:
ifeq ($(OS),Windows_NT)
	-rmdir /s /q $(BIN_DIR)
	-rmdir /s /q dist
else
	rm -rf $(BIN_DIR)
	rm -rf dist
endif


.PHONY: build-linux
build-linux:
	GOOS=linux GOARCH=amd64 $(GOBUILD) -ldflags "$(LDFLAGS)" \
	-o $(BIN_DIR)/$(APP)-linux-amd64 $(CMD)


.PHONY: build-darwin
build-darwin:
	GOOS=darwin GOARCH=amd64 $(GOBUILD) -ldflags "$(LDFLAGS)" \
	-o $(BIN_DIR)/$(APP)-darwin-amd64 $(CMD)


.PHONY: build-windows
build-windows:
	GOOS=windows GOARCH=amd64 $(GOBUILD) -ldflags "$(LDFLAGS)" \
	-o $(BIN_DIR)/$(APP)-windows-amd64.exe $(CMD)


.PHONY: build-all
build-all: build-linux build-darwin build-windows


.PHONY: release-check
release-check:
	goreleaser release --snapshot --clean

