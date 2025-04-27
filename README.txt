# debian-docker-sshd

FROM debian

default password: debian
sshd default port: 22

debian:bookworm     debian12
debian:bullseye     debian11
debian:buster       debian10

docker build -t debian12 .
docker build -t debian11 .
docker build -t debian10 .
