FROM fedora:25
LABEL maintainer "Octavian Ionescu <itavyg@gmail.com>"

COPY runTest.sh /usr/local/bin/runTest.sh

RUN set -ex && \
  groupadd -g 1000 nodejs && \
  useradd -g nodejs -G wheel -u 1000 nodejs && \
  echo "deltarpm=false" >> /etc/dnf/dnf.conf && \
  echo "fastestmirror=true" >> /etc/dnf/dnf.conf && \
  echo "timeout=30" >> /etc/dnf/dnf.conf && \
  echo "minrate=300k" >> /etc/dnf/dnf.conf && \
  dnf groupinstall -y "Development tools" && \
  dnf install -y which python gcc-c++ procps-ng sudo tar && \
  sed -i 's/Defaults   !visiblepw/#Defaults   !visiblepw/' /etc/sudoers && \
  sed -i 's/%wheel  ALL=(ALL)       ALL/#%wheel  ALL=(ALL)       ALL/' /etc/sudoers && \
  sed -i 's/# %wheel        ALL=(ALL)       NOPASSWD: ALL/%wheel        ALL=(ALL)       NOPASSWD: ALL/' /etc/sudoers && \
  chown -R nodejs. /opt

ENV NODEJS_MOUNTPOINT="/opt/nodejs-src"

USER nodejs
CMD ["/usr/local/bin/runTest.sh"]

