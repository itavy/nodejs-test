FROM alpine:latest
LABEL maintainer "Octavian Ionescu <itavyg@gmail.com>"

COPY getSource.sh /usr/local/bin/getSource.sh

RUN apk add --no-cache git shadow sudo && \
  addgroup -g 1000 nodejs && \
  adduser -D -G nodejs -u 1000 nodejs && \
  usermod -a -G wheel nodejs && \
  mkdir /opt && \
  chown -R nodejs. /opt && \
  echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
  chmod +x /usr/local/bin/getSource.sh

ENV NODEJS_SYNC_MASTER=0 \
  NODEJS_GIT_MASTER_FOLDER="/opt/nodejs-master-src" \
  NODEJS_GIT_FOLDER="/opt/nodejs-src" \
  NODEJS_GIT_URL="https://github.com/nodejs/node.git" \
  NODEJS_COMMIT="master"
  
USER nodejs
CMD ["/usr/local/bin/getSource.sh"]
