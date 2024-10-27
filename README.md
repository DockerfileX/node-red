# Node-RED

## 1. 简介

Environment for **Node-RED** Appication

为运行 **Node-REDx** 应用而提供的环境

## 2. 特性

* Alpine
* Node-RED 4.0.5
* TZ=Asia/Shanghai
* telnet
* many nodes
* work dir: /usr/src/node-red
* data dir: /data

## 3. 编译并上传镜像

```sh
docker buildx build --platform linux/arm64,linux/amd64 -t nnzbz/node-red:4.0.5 --build-arg VERSION=4.0.5 . --push
docker buildx build --platform linux/arm64,linux/amd64 -t nnzbz/node-red:4.0 --build-arg VERSION=4.0.5 . --push
docker buildx build --platform linux/arm64,linux/amd64 -t nnzbz/node-red:latest --build-arg VERSION=4.0.5 . --push
```

## 4. 单机

```sh
docker run -d --net=host --name 容器名称 --init -v /usr/local/外部程序所在目录:/usr/local/myservice --restart=always nnzbz/vertx-app
```

## 5. Swarm

- Docker Compose

```yaml{.line-numbers}
version: "3.9"
services:
  svr:
    image: nnzbz/vertx-app
    init: true
    # environment:
    #   - JAVA_OPTS=-Xms100M -Xmx100M
    volumes:
      # 初始化脚本
      #- /usr/local/xxx-svr/init.sh:/usr/local/myservice/init.sh:z
      # 配置文件目录
      - /usr/local/xxx-svr/conf/:/usr/local/myservice/conf/:z
      # lib目录(存放外部jar包)
      #- /usr/local/xxx-svr/lib/:/usr/local/myservice/lib/:z
      # 运行的jar包
      - /usr/local/xxx-svr/xxx-svr-x.x.x-fat.jar:/usr/local/myservice/myservice.jar:z
    deploy:
      placement:
        constraints:
          # 部署的节点指定是app角色的
          - node.labels.role==app
      # 默认副本数先设置为1，启动好后再用 scale 调整，以防第一次启动初始化时并发建表
      replicas: 1

networks:
  default:
    external: true
    name: rebue
```

- 部署

```sh
docker stack deploy -c /usr/local/xxx-svr/stack.yml xxx
```
