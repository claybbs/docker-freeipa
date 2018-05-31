# Clone from the CentOS 7
FROM centos:centos7

MAINTAINER Clay Chen

RUN yum swap -y -- remove fakesystemd systemd-container systemd-container-libs -- install systemd  systemd-libs  && yum clean all

RUN yum install -y  openssh openssh-clients openssh-server sshpass vim dbus nc sshpass rsync  net-tools rsyslog lrzsz zip unzip lftp sudo tar mtr && yum clean all

# Install FreeIPA client
RUN yum install -y oddjob oddjob-mkhomedir ipa-client dbus-python perl 'perl(Data::Dumper)' 'perl(Time::HiRes)' && yum clean all


RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_ecdsa_key -N '' -t ecdsa
RUN ssh-keygen -A

RUN echo "root:jump" | chpasswd

ADD dbus.service /etc/systemd/system/dbus.service
RUN ln -sf dbus.service /etc/systemd/system/messagebus.service


ADD systemctl /usr/bin/systemctl
ADD sshd_config /etc/ssh/sshd_config
ADD profile /etc/profile

ADD ipa-client-configure-first /usr/sbin/ipa-client-configure-first

RUN mkdir -p /var/dbus
RUN chmod -v +x /usr/bin/systemctl /usr/sbin/ipa-client-configure-first

RUN systemctl enable sshd  && rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime 

RUN (mkdir -p /var/log/session/;\
     chmod 777 /var/log/session)

VOLUME ["/home"]
VOLUME ["/var/log/session"]
VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run/dbus"]

EXPOSE 22
ENTRYPOINT /usr/sbin/ipa-client-configure-first
