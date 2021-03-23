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
echo "152 468" >> _tmp_locales_set
echo "2" >> _tmp_locales_set
dpkg-reconfigure locales < _tmp_locales_set >/dev/null 2>&1
rm -rf _tmp_locales_set

# 设定系统语言环境
ENV LANG="en_US.UTF-8"
ENV LANGUAGE="en_US:en"

# 配置系统时区
apt install tzdata -y
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# 清理环境
apt remove -y tzdata
apt purge -y --auto-remove
apt clean && apt autoclean
rm -rf /tmp/*

