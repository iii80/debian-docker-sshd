FROM debian

WORKDIR /root
COPY *.sh /root/
RUN sh init.sh
EXPOSE 22

# 启动命令行
CMD ["/usr/sbin/sshd", "-D"]
