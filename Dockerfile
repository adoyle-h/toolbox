FROM alpine:3.15.0
# FROM alpine:3.15.0 AS builder

WORKDIR /root

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories

RUN apk update

# build/code
RUN apk add --no-cache \
    build-base git go bash bash-completion ncurses neovim tmux jq

# network
RUN apk add --no-cache \
    bind-tools iputils tcpdump curl nmap tcpflow iftop net-tools mtr netcat-openbsd \
    bridge-utils iperf3 ngrep conntrack-tools

# certificates
RUN apk add --no-cache ca-certificates openssl

# processes/io
RUN apk add --no-cache \
    htop atop strace iotop sysstat ltrace ncdu logrotate hdparm pciutils psmisc tree pv

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENTRYPOINT bash
LABEL maintainer="ADoyle <adoyle.h@gmail.com>"
ENV TZ=Asia/Shanghai
