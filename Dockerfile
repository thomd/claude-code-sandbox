FROM node:24-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    curl \
    jq \
    gh \
    ripgrep \
    procps \
    build-essential \
    file \
    bubblewrap \
    socat \
    tinyproxy \
    && rm -rf /var/lib/apt/lists/*

ARG CLAUDE_CODE_VERSION=latest
ARG FORCE_INSTALL=1
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

ENV CLAUDE_CODE_DISABLE_FEEDBACK_SURVEY=1

ARG HOST_UID
ARG HOST_GID
RUN useradd -u ${HOST_UID} -g ${HOST_GID} -d /home/claude -s /bin/bash -M claude
RUN mkdir -p /home/claude
RUN chmod 777 /home/claude
RUN echo 'alias l="ls -al"' >> /etc/bash.bashrc
RUN echo 'alias ..="cd .."' >> /etc/bash.bashrc
RUN echo 'PS1="claude: \w\$ "' >> /etc/bash.bashrc

COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
COPY .claude-sandbox/proxy-filter /etc/tinyproxy/filter
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["bash"]
