## centos7-sshd-freeipa-client
- 包含sshd,freeipa-client
- 包含常用工具

## 注意,下面两个必须挂载:
- volume:/run/dbus:ro
- volume:/sys/fs/cgroup:ro
## 注意，宿主机请为centos7，并且手工部署了ipa-client:yum install freeipa-client
