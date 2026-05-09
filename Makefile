IMAGE := claude-code-sandbox
CLAUDE_CODE_VERSION ?= latest
BINDIR := $(or $(XDG_BIN_HOME),$(HOME)/.local/bin)

BUILD_ARGS := --build-arg CLAUDE_CODE_VERSION=$(CLAUDE_CODE_VERSION)
ifeq ($(CLAUDE_CODE_VERSION),latest)
  BUILD_ARGS += --build-arg CACHEBUST=$(shell date +%s)
endif

.PHONY: install uninstall
install:
	docker build $(BUILD_ARGS) -t $(IMAGE) .
	mkdir -p $(BINDIR)
	ln -sf $(CURDIR)/claude-sandbox $(BINDIR)/claude-sandbox

uninstall:
	docker rmi $(IMAGE)
	rm -f $(BINDIR)/claude-sandbox
