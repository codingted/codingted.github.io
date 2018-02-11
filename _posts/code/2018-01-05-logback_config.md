---
title: logback配置文件示例
categories: code
tags: log logback
comments: true
---

# 概览

`Logback`是`log4j`的继者.他是由同一个开发者[]()在log4j的基础之上添加了一系列的优化.

## Logback与log4j的比较

* 同样的代码路径，Logback 执行更快
* 更充分的测试
* 原生实现了 SLF4J API（Log4J 还需要有一个中间转换层）
* 内容更丰富的文档
* 支持 XML 或者 Groovy 方式配置
* 配置文件自动热加载
* 从 IO 错误中优雅恢复
* 自动删除日志归档
* 自动压缩日志成为归档文件
* 支持 Prudent 模式，使多个 JVM 进程能记录同一个日志文件
* 支持配置文件中加入条件判断来适应不同的环境
* 更强大的过滤器
* 支持 SiftingAppender（可筛选 Appender）
* 异常栈信息带有包信息

<!-- more -->

# 配置

Logback的配置支持:编程式/xml/groovy三种格式的配置.

在Logback启动时,会根据一下步骤查找配置文件:

1. 在 classpath 中寻找 logback-test.xml文件
2. 如果找不到 logback-test.xml，则在 classpath 中寻找 logback.groovy 文件
3. 如果找不到 logback.groovy，则在 classpath 中寻找 logback.xml文件
4. 如果上述的文件都找不到，则 logback 会使用 JDK 的 SPI 机制查找 META-INF/services/ch.qos.logback.classic.spi.Configurator 中的 logback 配置实现类，这个实现类必须实现 Configuration 接口，使用它的实现来进行配置
5. 如果上述操作都不成功，logback 就会使用它自带的 BasicConfigurator 来配置，并将日志输出到 console

```xml
<configuration>
    <!--<statusListener class="ch.qos.logback.core.status.NopStatusListener" />-->
    <jmxConfigurator/>
    
    <!-- 控制台输出 -->
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <pattern>
                [%d{yyyy-MM-dd HH:mm:ss.SSS}] [%-36.36thread] [%-5level] [%-36.36logger{36}:%-4.4line] - %msg%n
            </pattern>
        </encoder>
    </appender>
    <!-- 按照每天生成日志文件 -->
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${log.path}/${app.name}/sys.log</file>
        <!--拒绝ERROR日志-->
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>ERROR</level>
            <onMatch>DENY</onMatch>
            <onMisMatch>NEUTRAL</onMisMatch>
        </filter>
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>${log.lowest.level}</level>
            <onMatch>ACCEPT</onMatch>
            <onMismatch>DENY</onMismatch>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <FileNamePattern>${log.path}/${app.name}/sys-%d{yyyy-MM-dd}-%i.log</FileNamePattern>
            <MaxHistory>90</MaxHistory>
            <TimeBasedFileNamingAndTriggeringPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
                <MaxFileSize>10MB</MaxFileSize>
            </TimeBasedFileNamingAndTriggeringPolicy>
        </rollingPolicy>
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <pattern>
                [%d{yyyy-MM-dd HH:mm:ss.SSS}] [%-36.36thread] [%-5level] [%-36.36logger{36}:%-4.4line] - %msg%n
            </pattern>
        </encoder>
    </appender>
    <appender name="FILE-ERROR" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>${log.path}/${app.name}/sys-err.log</file>
        <filter class="ch.qos.logback.classic.filter.LevelFilter">
            <level>ERROR</level>
            <onMatch>ACCEPT</onMatch>
            <onMismatch>DENY</onMismatch>
        </filter>
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
            <FileNamePattern>${log.path}/${app.name}/sys-err-%d{yyyy-MM-dd}-%i.log</FileNamePattern>
            <MaxHistory>90</MaxHistory>
            <TimeBasedFileNamingAndTriggeringPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
                <MaxFileSize>10MB</MaxFileSize>
            </TimeBasedFileNamingAndTriggeringPolicy>
        </rollingPolicy>
        <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
            <pattern>[%d{yyyy-MM-dd HH:mm:ss.SSS}] [%-36.36thread] [%-5level] [%-36.36logger{36}:%-4.4line] - %msg%n
            </pattern>
        </encoder>
    </appender>

    <!-- show parameters for hibernate sql 专为 Hibernate 定制 -->
    <logger name="org.hibernate.type.descriptor.sql.BasicBinder"    additivity="true" level="${log.hibernate.level}" />
    <logger name="org.hibernate.type.descriptor.sql.BasicExtractor" additivity="true" level="${log.hibernate.level}" />
    <logger name="org.hibernate.SQL"                                additivity="true" level="${log.hibernate.level}" />
    <logger name="org.springframework"                              additivity="true" level="${log.spring.level}"/>
    <logger name="com.myown"                                        additivity="true" level="${log.root.level}"/>

    <!-- 日志输出级别 -->
    <root level="${log.root.level}">
        <appender-ref ref="STDOUT"/>
        <appender-ref ref="FILE"/>
        <appender-ref ref="FILE-ERROR"/>
    </root>

</configuration>
```

配置文件中的变量是需要在我而不应用启动前加载的,两种方式

1. 设置JVM启动参数 -Dlog.hibernate.level=DEBUG -Dlog.spring.level=INFO
2. 在tomcat的bin文件夹下新增一个(windows下一bat结尾,Unix like 为sh结尾的文件),setevn.bat/.sh的文件

# 参考链接
* [https://segmentfault.com/a/1190000008315137](https://segmentfault.com/a/1190000008315137)
* [https://logback.qos.ch/](https://logback.qos.ch/)
