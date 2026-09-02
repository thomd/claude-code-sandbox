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
	rsync -a --ignore-existing .claude-sandbox/ $(CONFIGDIR)/

update:
	docker build $(BUILD_ARGS) -t $(IMAGE) .

uninstall:
	if docker image inspect $(IMAGE) >/dev/null 2>&1; then docker rmi $(IMAGE); fi
	rm -f $(BINDIR)/claude-sandbox
	rm -rf $(CONFIGDIR)
