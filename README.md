
### DESCRIBE

* linux服务器端口与应用信息统计汇总表服务（一个服务信息汇总表）


***服务名-版本***：

* serverInfo-v1.0


***相关框架组件***：

* springboot(2.0.6)、vue(2.4.2)、bootstrap(3.3.7)、axios(0.18)、jq-paginator(2.0.2)、jquery(2.11)...


***部署环境***：

* Docker(18.09.4)


***范围***：

* (1).多字段连接模糊匹配查询（全表模糊匹配）;
* (2).输入与查询关键词高亮显示（vue数据双向绑定搭配过滤器文本替换）;
* (3).前后端分页组件搭配...


***功能区***：

![服务添加和查询功能](server_add_search.gif)

---------

### API


##### backend server api: 
	
	1.1) index: 
	
	```[GET] http://127.0.0.1:8081```

	1.2) server default list: 
	
	```[GET] http://127.0.0.1:8081/serverInfo?pageNum=1&pageSize=5```
	
	1.3) server keyword list: 
	
	```[GET] http://127.0.0.1:8081/serverInfo/keyword?keyword=XX&pageNum=1&pageSize=10```

	1.4) server add & update: 
	
	```[POST] http://127.0.0.1:8081/serverInfo/edit; -d "{\"id\":7, \"port\":12100, \"name\":\"server-info(v1.0)\", \"purpose\":...}"```


---------

### DEPLOY

##### Dockerfile: 

```shell
# 依赖基础镜像(jdk1.8.0_191自建，其依赖基础镜像centos7)
FROM jdk1.8.0_191/centos7

MAINTAINER cj

# 设置环境变量(docker版容器中若无zh_CN)
ENV LANG en_HK.utf8
ENV SERVER_PATH /home/labelpad/backend/server_info

RUN mkdir -p ${SERVER_PATH}

# 工作空间(切换)
WORKDIR ${SERVER_PATH}

COPY serverInfo.jar ./

# 设置共享目录
VOLUME  ${SERVER_PATH}

# 容器内部暴露端口
EXPOSE 12100

# 设置容器启动执行命令
ENTRYPOINT ["java", "-jar", "-Dserver.port=${SERVER_PORT}",  "serverInfo.jar", "--spring.profiles.active=${SERVER_PROFILES}"]
```

