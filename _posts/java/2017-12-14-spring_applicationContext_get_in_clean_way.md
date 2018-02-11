---
title:  "获取ApplicationContext"
categories: java
tags: spring code
comments: true
---

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

<!-- more -->

**另外一种注解实现的方式**

```java
@Component
@Lazy(false)
public class ApplicationContextProvider implements ApplicationContextAware {
    private static ApplicationContext applicationContext;
    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        this.applicationContext = applicationContext;
    }
    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }
    public static Object getBean(String name) {
        return getApplicationContext().getBean(name);
    }
    public static <T> T getBean(Class<T> clazz) {
        return getApplicationContext().getBean(clazz);
    }
    public static <T> T getBean(String name, Class<T> clazz) {
        return getApplicationContext().getBean(name, clazz);
    }
}

```
