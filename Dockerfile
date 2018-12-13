FROM fedora:rawhide
MAINTAINER František Dvořák <valtri@civ.zcu.cz>

RUN dnf install -y git java-1.8.0-openjdk-headless openssh-server sudo \
 && dnf install -y policycoreutils-newrole \
 && dnf clean all \
 && rm -rf /var/cache/dnf/*

RUN for a in rsa ecdsa ed25519; do /usr/libexec/openssh/sshd-keygen $a; done \
 && rm -fv /run/nologin \
 && useradd -m -d /home/jenkins -s /bin/bash jenkins \
 && sed -i '/root\tALL=/a jenkins ALL=(ALL) NOPASSWD: ALL' /etc/sudoers

EXPOSE 22

COPY docker-entry.sh /
CMD ["/docker-entry.sh", "/usr/sbin/sshd", "-D"]
