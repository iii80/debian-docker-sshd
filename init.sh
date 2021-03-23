#! /bin/sh

apt update
apt upgrade -y

apt install -y openssh-server vim screen unzip curl

# 允许密码登录
mkdir /var/run/sshd
sed -i "/PermitRootLogin/s/#Permit/Permit/" /etc/ssh/sshd_config
sed -i "/PermitRootLogin/s/prohibit-password/yes/" /etc/ssh/sshd_config
sed -i "s/UsePAM yes/#UsePAM yes/g" /etc/ssh/sshd_config

echo 'root:debian' | chpasswd

# 安装配置系统语言环境
apt install locales -y
locale-gen --no-purge en_US.UTF-8
update-locale LANG=en_US.UTF-8

# 配置系统时区
apt install tzdata -y
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 清理环境
apt purge -y --auto-remove
apt clean && apt autoclean
rm -rf /tmp/*

