---
layout: post
title:  "接口开发从前到后-后端开发"
categories: java
tags: API 接口
comments: true
---

* content
{:toc}

# 后端开发工具包

* jdk1.7
* spring 3.0.5

# 后端controller

```
package com.motie.wings.web.ajax;

import com.motie.wings.pojo.writing.Book;
import com.motie.wings.service.IBookService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

/**
 * @author codingted
 * @date 17-8-10
 */
@Controller
@RequestMapping("/books")
public class BookController {







    @Resource
    private IBookService bookService;

    @RequestMapping(method = RequestMethod.POST)
    public @ResponseBody Object addBook(HttpServletRequest request, HttpServletResponse response,
                                        @RequestBody Book book) {
        //...
    }

    @RequestMapping(value = "/{bookId}", method = RequestMethod.DELETE)
    public @ResponseBody Object updateBook(HttpServletRequest request, HttpServletResponse response,
                                           @PathVariable Integer bookId) {
        //...
    }

    @RequestMapping(value = "/{bookId}", method = RequestMethod.PUT)
    public @ResponseBody Object updateBook(HttpServletRequest request, HttpServletResponse response,
                                           @RequestBody Book book) {
        //...
    }

    @RequestMapping(value = "/{bookId}", method = RequestMethod.GET)
    public @ResponseBody Object getBook(HttpServletRequest request, HttpServletResponse response,
                                        @PathVariable Integer bookId) {
        //...
    }

    @RequestMapping(value = "", method = RequestMethod.GET)
    public @ResponseBody Object getBook(HttpServletRequest request, HttpServletResponse response,
                                        @PathVariable Integer bookId,
                                        @RequestBody Map<String, Object> searchParam) {
        //...
    }

}

```

> @Controller : 注解该类是用来处理HTTP请求的    
> @RequestMapping : 注解使用的HTTP方法（GET/POST/PUT/DELETE),HTTP的header,URIs  
> @PathVariable : 注入URI中“{}”中的内容     
> @RequestParam : 注入URL中“？”后边的参数   
> @RequestHeader: 注入通过header传递的参数  
> @RequestBody  : 注入requestBody参数（json/xml...）    
> @ResponseBody : 將返回的对象序列化（通过HttpMessageConverter）    


## HttpMessageConverter

converter                   | 说明
----------------------------|------------
StringhttpMessageConverter  | 支持的媒体类型text/* 以Content-Type=text/plain格式输出
FormHttpMessageConverter    | 支持application/x-www-form-urlencoded类型的输入，输出为MultiValueMapl\<String,String>
MappingJacksonHttpMessageConverter | 支持JSON数据使用Jackson's ObjectMapper, 转换媒体类型为application/json类型的数据
MarshallingHttpMessageConverter    | 支持application/xml数据类型的序列化和反序列化

### converter配置

```
<bean class="org.springframework.web.servlet.mvc.annotation .AnnotationMethodHandlerAdapter">
   <property name="messageConverters">
      <list>
         <ref bean="jsonConverter" />
         <ref bean="marshallingConverter" />
         <ref bean="atomConverter" />
      </list>
    </property>
</bean>
<bean id="jsonConverter" class="org.springframework.http.converter.json .MappingJacksonHttpMessageConverter">
   <property name="supportedMediaTypes" value="application/json" />
</bean>

```
### 生命接收的数据类型
```
headers=”Accept=application/json, application/xml”
```

# 前后交互的注意点

前端            | 后端
----------------|--------------------
url?p1=a&p2=b   | @RequestParam 接收（String, Map）
form表单提交(x-www-formurlencode)   | @RequestParam 接收（String, Map)
form表单提交(multipart/form-data)   | 接收Object类型的参数
提交json/xml数据                    | @RequestBody 接收并确认配置了相应的converter



> application/x-www-form-urlencoded和multipart/form-data
>
> form提交时默认为application/x-www-form-urlencoded。   
> 当action为get时候，浏览器用x-www-form-urlencoded的编码方式把form数据转换成一个字串（name1=value1&name2=value2...），在这个过程中会將no-alphanumeric字符替换为'%HH'(一个百分号加两个16进制的ASCII码)的形式,然后把这个字串append到url后面，用?分割，加载这个新的url。   
> 当action为post时候，浏览器把form数据封装到http body中，然后发送到server。     
> 如果没有type=file的控件，用默认的application/x-www-form-urlencoded就可以了。 但是如果有type=file的话，就要用到multipart/form-data了。浏览器会把整个表单以控件为单位分割，并为每个部分加上Content-Disposition(form-data或者file),Content-Type(默认为text/plain),name(控件name)等信息，并加上分割符(boundary)。 
