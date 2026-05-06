FROM node:24-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends git ca-certificates curl jq gh less
RUN rm -rf /var/lib/apt/lists/*

ARG CLAUDE_CODE_VERSION=latest
ARG FORCE_INSTALL=1
RUN npm install -g @anthropic-ai/claude-code@${CLAUDE_CODE_VERSION}

RUN mkdir -p /home/claude
RUN chmod 777 /home/claude
RUN echo 'PS1="claude: \w\$ "' >> /etc/bash.bashrc

CMD ["bash"]
