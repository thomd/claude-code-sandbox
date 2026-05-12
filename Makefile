IMAGE := claude-code-sandbox
CLAUDE_CODE_VERSION ?= latest
BINDIR := $(or $(XDG_BIN_HOME),$(HOME)/.local/bin)
CONFIGDIR := $(or $(XDG_CONFIG_HOME),$(HOME)/.config)/claude-sandbox

BUILD_ARGS := --build-arg CLAUDE_CODE_VERSION=$(CLAUDE_CODE_VERSION) \
              --build-arg HOST_UID=$(shell id -u) \
              --build-arg HOST_GID=$(shell id -g)
ifeq ($(CLAUDE_CODE_VERSION),latest)
  BUILD_ARGS += --build-arg CACHEBUST=$(shell date +%s)
endif

.PHONY: install uninstall
install:
	docker build $(BUILD_ARGS) -t $(IMAGE) .
	mkdir -p $(BINDIR)
	ln -sf $(CURDIR)/claude-sandbox $(BINDIR)/claude-sandbox
	mkdir -p $(CONFIGDIR)
	cp -rn .claude-sandbox/. $(CONFIGDIR)/

uninstall:
	docker rmi $(IMAGE)
	rm -f $(BINDIR)/claude-sandbox
	rm -rf $(CONFIGDIR)
