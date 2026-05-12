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

## On Security

- `--user "$(id -u):$(id -g)"` sets the actual process identity at runtime, overriding whatever the container's `/etc/passwd` says. Docker with `--user uid:gid` also doesn't load supplementary groups from the container's `/etc/group`.
- `--cap-drop=ALL` removes all Linux capabilities (no raw sockets, no mounting, no privilege manipulation)
- `--security-opt=no-new-privileges` blocks setuid escalation
- Port binding is locked to `127.0.0.1`
- Mounts are minimal — no `~/.ssh`, `~/.aws`, or home directory beyond the claude config
- `$PWD` is mounted with full read/write. Any secrets in the project (`.env`, hardcoded keys, etc.) are readable. This is unavoidable for a coding agent but important to be aware of.

### Current Issues

- No network restriction. The container has unrestricted outbound internet access. In yolo mode, an agent can exfiltrate files or call external APIs. Adding `--network none` (or a restricted bridge) would mitigate this, but would break agents that need to fetch packages or call APIs intentionally. This is a trade-off.
- The `$CONFIG_DIR` mount contains the Claude API key. The agent can read its own credentials at `/home/claude/.claude`. In yolo mode it could use them to spawn further requests outside the container.
