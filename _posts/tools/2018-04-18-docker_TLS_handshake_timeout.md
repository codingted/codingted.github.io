---
title: 使用docker时报错'TLS handshake timeout'
categories: tools
tags: docker
---

# 问题产生

拉取docker镜像时(执行`docker pull elasticsearch`),报错

```shell
docker: error pulling image configuration: (此处省略100+字母): net/http: TLS handshake timeout. 
````
# 解决途径

* 开启命令行代理(未解决)
* 使用国内的镜像加速地址(修改`/etc/default/docker`添加`DOCKER_OPTS="http://hub-mirror.c.163.com"`)(未解决)
* 将拉取地址改为国内镜像仓库

    > #修改/etc/docker/daemon.json(如果不存在则创建)  
    > #添加下面的代码
    >``` json
    >{
    >      "registry-mirrors": ["https://registry.docker-cn.com"]
    >}
    >```
    > #执行以下命令重启docker
    > ```bash
    > service docker restart
    > ```

