IMAGE := claude-code-sandbox
CLAUDE_CODE_VERSION ?= latest

BUILD_ARGS := --build-arg CLAUDE_CODE_VERSION=$(CLAUDE_CODE_VERSION)
ifeq ($(CLAUDE_CODE_VERSION),latest)
  BUILD_ARGS += --build-arg CACHEBUST=$(shell date +%s)
endif

.PHONY: install
install:
	docker build $(BUILD_ARGS) -t $(IMAGE) .
