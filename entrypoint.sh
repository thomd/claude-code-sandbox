#!/usr/bin/env bash
set -euo pipefail

tinyproxy -c /etc/tinyproxy/tinyproxy.conf

for _ in $(seq 10); do
  curl -s -o /dev/null --proxy http://127.0.0.1:8888 http://127.0.0.1 && break
  sleep 0.2
done

export http_proxy=http://127.0.0.1:8888
export https_proxy=http://127.0.0.1:8888
export HTTP_PROXY=http://127.0.0.1:8888
export HTTPS_PROXY=http://127.0.0.1:8888
export no_proxy=localhost,127.0.0.1
export NO_PROXY=localhost,127.0.0.1

exec "$@"
