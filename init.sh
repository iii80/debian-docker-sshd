#! /bin/bash

set -x

#安装常用软件
apt update
apt install -y openssh-server vim screen locales tzdata htop nload ncdu wget curl tar gzip bzip2 xz-utils unzip net-tools sudo ca-certificates

# 允许密码登录
mkdir /var/run/sshd
sed -i "/PermitRootLogin/s/#Permit/Permit/" /etc/ssh/sshd_config
sed -i "/PermitRootLogin/s/prohibit-password/yes/" /etc/ssh/sshd_config
sed -i "s/UsePAM yes/#UsePAM yes/g" /etc/ssh/sshd_config

# 设置root密码
echo 'root:debian' | chpasswd

# 安装配置系统语言环境
sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen
sed -i '/zh_CN.UTF-8/s/^# //g' /etc/locale.gen

locale-gen
update-locale LANG=en_US.UTF-8

# 配置系统时区
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata

# 清理环境
apt purge -y --auto-remove
apt clean && apt autoclean
rm -rf /tmp/*

