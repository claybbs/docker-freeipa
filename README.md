# docker-freeipa
## 包含内容:
- centos6.7常用工具
- freeipa client
- sshd server
- 该image用作堡垒机，因此带自动记录用户terminal session

## docker环境变量:
- IPA_CLIENT_INSTALL_OPTS:--mkhomedir --force-join --domain=freeipa-server.freeipa.com  --server=freeipa-server.freeipa.com #这里填写的是freeipa-server的信息，请跟进实际情况修改
- PASSWORD:root #freeipa 系统中账号admin 使用的密码

## 暴露端口:22

## 外挂volume:
- /home #用户的家目录
- /var/log/session #用户的终端日志记录，可能需要在nfs配置该目录权限为chmod 777 

## 运行容器的时候，请修改容器的主机名!

### freeipa-server 参考：https://github.com/freeipa/freeipa-container
