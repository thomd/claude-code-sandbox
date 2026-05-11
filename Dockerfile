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
    && rm -rf /var/lib/apt/lists/*

ARG CLAUDE_CODE_VERSION=latest
ARG FORCE_INSTALL=1
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

RUN mkdir -p /home/claude
RUN chmod 777 /home/claude
RUN echo 'alias l="ls -al"' >> /etc/bash.bashrc
RUN echo 'alias ..="cd .."' >> /etc/bash.bashrc
RUN echo 'PS1="claude: \w\$ "' >> /etc/bash.bashrc

CMD ["bash"]
