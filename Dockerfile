FROM ubuntu:22.04
RUN apt update -y \
apt install zmap
COPY . /root/
