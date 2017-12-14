---
layout: post
title:  "获取ApplicationContext"
categories: java
tags: spring code
comments: true
---

* content
{:toc}


```java
public class ApplicationContextProvider implements ApplicationContextAware {
    private static ApplicationContext context;
 
    public ApplicationContext getApplicationContext() {
        return context;
    }
 
    @Override
    public void setApplicationContext(ApplicationContext ctx) {
        context = ctx;
    }
}

```

在applicationContext配置文件中

```xml
<bean id="applicationContextProvder" class="org.myApp.ApplicationContextProvider"/>
```

调用

```java
MyBean c = ApplicationContextProvider.getApplicationContext.getBean("BeanId", MyBean.class);
```
