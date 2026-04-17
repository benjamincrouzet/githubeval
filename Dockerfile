FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    nginx \
    openssh-server \
    iputils-ping \
    net-tools \
    nano \
    python3 \
    sudo \
    sshpass \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd \
 && ssh-keygen -A

RUN echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config \
 && echo 'Port 22' >> /etc/ssh/sshd_config \
 && echo 'PubkeyAuthentication yes' >> /etc/ssh/sshd_config \
 && echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config

RUN echo 'root:root' | chpasswd

EXPOSE 80 22

CMD ["/usr/sbin/sshd", "-D"]