# Claude Code Sandbox

> [!IMPORTANT]
> This Claude Code Sandbox was only tested on MacOS - it might not run on your system.

## Setup

```
git clone https://github.com/thomd/claude-code-sandbox ~/.local/share/claude-sandbox
cd ~/.local/share/claude-sandbox
make install
```

## Usage

```
alias cs='claude-sandbox claude --dangerously-skip-permissions'
```


- override at build time with `--build-arg CLAUDE_CODE_VERSION=x.y.z`

## TODO

- [X] Makefile for install, uninstall and update
- [X] install executable in ~/.local/bin
- [X] install repo in ~/.local/share/claude-sandbox
- [ ] Enable native sandbox support by default
- [ ] add hooks for deterministic tooling
