#!/usr/bin/env bash
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

if echo "$COMMAND" | grep -qE '(^|&&|\|\||;)\s*npm\s'; then
  echo "Blocked: Always use $(pnpm), not $(npm)" >&2
  exit 2
fi
exit 0
