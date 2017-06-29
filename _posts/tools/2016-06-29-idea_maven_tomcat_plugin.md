---
layout: post
title: IDEA配置maven tomcat插件Debug/热部署
categories: tools
tags: idea
---

* content
{:toc}

# 配置maven tomcat插件

## 集成tomcatX-maven-plugin

```xml
<plugin>
    <groupId>org.apache.tomcat.maven</groupId>
    <artifactId>tomcat7-maven-plugin</artifactId>
    <!-- or if you want to use tomcat 6.x -->
    <!--<artifactId>tomcat6-maven-plugin</artifactId>-->
    <version>2.2</version>
    <configuration>
    <path>/</path>
  </configuration>
</plugin>
```

现在只需要运行就可以运行项目了

```
mvn clean tomcat7:run
```
> 但是这仅仅是运行项目，在这种情况下不能debug也没有热部署的功能，每次必须进行关闭 **mvn tomcat7:shutdown**

## Idea Debug配置

* 添加maven的Run/Debug项（Run->Edit Config）

![选择maven](http://www.codingted.com:9090/tool/img/idea_debug.jpg)

* 填写相应的命令

![填写运行命令](http://www.codingted.com:9090/tool/img/idea_debug_2.jpg)

> 这样只要进行debug启动就可以调试了但是，改完以后idea是不会自动部署的。

## Idea 热部署

> 这种方法是通过tomcat的管理后天进行热部署

### 相关的步骤如下

* 修改tomcat的tomcat-users.xml

```xml
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager"/>
<role rolename="manager-script"/>
<role rolename="manager-gui"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="admin" password="admin" roles="admin,manager,manager-gui,admin-gui,manager-script,manager-jmx,manager-status"/>
```

* 修改的pom文件的配置

```xml
<plugin>
  <groupId>org.apache.tomcat.maven</groupId>
  <artifactId>tomcat7-maven-plugin</artifactId>
  <!-- or if you want to use tomcat 6.x -->
  <!--<artifactId>tomcat6-maven-plugin</artifactId>-->
  <version>2.2</version>
  <configuration>
      <url>http://localhost:8080/manager/text</url>
      <server>tomcat</server>
      <username>admin</username>
      <password>admin</password>
      <uriEncoding>UTF-8</uriEncoding>
      <path>/</path>
  </configuration>
</plugin>
```

* 修改maven的setting.xml文件

编辑**~/.m2/setting.xml** 添加如下内容：

```xml
<settings>
  <servers>
    <server>
      <id>tomcat</id><!-- 这里的id和pom文件定义的server一致 -->
      <username>admin</username>
      <password>admin</password>
    </server>
  </servers>
</settings>
```

> 现在可以通过命令行来启动tomcat（**注意：是在外部不是通过mvn tomcat7:run进行启动的，因为这种条件下启动的配置和通过tomcat命令启动是不同的**）

现在通过**mvn tomcat7:deploy**进行部署就可以了

最后还是没有实现maven-tomcat插件既能debug又能热部署（又没闲钱使用JReble的服务，只能凑合着了），如果后续有好的方法在更新此文。
