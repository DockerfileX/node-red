ARG VERSION

# 使用 Node-RED 官方镜像作为基础镜像
FROM --platform=${TARGETPLATFORM} nodered/node-red:${VERSION}

ARG VERSION

# 作者及邮箱
# 镜像的作者和邮箱
LABEL maintainer="nnzbz@163.com"
# 镜像的版本
LABEL version=${VERSION}
# 镜像的描述
LABEL description="集成了Open JDK的操作系统"

USER root
# 更新
RUN apk update && apk upgrade
# 设置时区
RUN apk add tzdata
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone
RUN apk del tzdata
# 安装 telnet minicom
RUN apk add busybox-extras && apk -U add minicom
# 删除缓存
RUN rm -rf /var/cache/apk/*

# 安装额外的 Node-RED 节点
RUN npm install node-red-contrib-loop
RUN npm install node-red-contrib-ulid
RUN npm install node-red-dashboard
RUN npm install node-red-node-serialport
RUN npm install node-red-contrib-mpi-s7
RUN npm install node-red-contrib-s7
RUN npm install node-red-contrib-opcua
RUN npm install node-red-contrib-modbus
RUN npm install node-red-node-email
RUN npm install node-red-node-sqlite
RUN npm install node-red-node-mysql
RUN npm install node-red-contrib-postgresql



