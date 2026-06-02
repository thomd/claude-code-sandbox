# Claude Code Sandbox

> [!IMPORTANT]
> This Claude Code Sandbox was only tested on MacOS to fit my personal needs - it might not run on your system.

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

## Update

To update `claude`, run

```
make update
```

## On Security

- `--user "$(id -u):$(id -g)"` sets the actual process identity at runtime, overriding whatever the container's `/etc/passwd` says. Docker with `--user uid:gid` also doesn't load supplementary groups from the container's `/etc/group`.
- `--cap-drop=ALL` removes all Linux capabilities (no raw sockets, no mounting, no privilege manipulation)
- `--security-opt=no-new-privileges` blocks setuid escalation
- Port binding is locked to `127.0.0.1`
- Mounts are minimal — no `~/.ssh`, `~/.aws`, or home directory beyond the claude config
- `$PWD` is mounted with full read/write. Any secrets in the project (`.env`, hardcoded keys, etc.) are readable. This is unavoidable for a coding agent but important to be aware of.

### Egress Filtering

Outbound traffic is filtered via [tinyproxy](https://tinyproxy.github.io/) running inside the container. Only domains on the allowlist can be reached.

Customise the allowlist without rebuilding the image by editing `~/.config/claude-sandbox/proxy-filter`. Each line is an extended regex matched against the request hostname, for example:

```
(^|\.)example\.com$
```

Known limitation: Node.js's built-in `fetch()` bypasses proxy env vars, so the Claude Code process itself reaches `api.anthropic.com` directly. All shell-invoked tools are still filtered.
