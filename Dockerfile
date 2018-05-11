# Clone from the RHEL 6
FROM centos:6.7

MAINTAINER Clay Chen

# Install FreeIPA client
RUN yum install -y ipa-client perl && yum clean all

# Install sshd server
RUN yum install -y openssh openssh-server openssh-clients vim zip net-tools nc telnet tar unzip && yum clean all

RUN echo 'root:Leanwork2018' | chpasswd

RUN (sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config;\
     sed -i 's/#ClientAliveInterval 0/ClientAliveInterval 60/' /etc/ssh/sshd_config;\
     sed -i 's/#ClientAliveCountMax 3/ClientAliveCountMax 3/' /etc/ssh/sshd_config)

# user terminater log file
RUN (mkdir -p /var/log/session/;\
     chmod 777 /var/log/session)

ADD ipa-client-configure-first /usr/sbin/ipa-client-configure-first

ADD profile /etc/profile

RUN chmod -v +x /usr/sbin/ipa-client-configure-first

RUN /sbin/service sshd start && /sbin/service sshd stop

VOLUME ["/home"]
VOLUME ["/var/log/session"]

ENTRYPOINT /usr/sbin/ipa-client-configure-first

EXPOSE 22
