---
layout: post
title: Ajax form表单提交
categories: js
tags: ajax
---

* content
{:toc}

# 原生FormData对象使用

* HTML创建form对象
```
var formElement = document.querySelector("form");
//或者这种写法
//var formData = new FormData(someFormElement);
var request = new XMLHttpRequest();
request.open("POST", "submitform.php");
request.send(new FormData(formElement));
```
* 创建FormData对象
```js
var formData = new FormData();

formData.append("username", "Groucho");
formData.append("accountnum", 123456); // 数字 123456 会被立即转换成字符串 "123456"

// HTML 文件类型input，由用户选择
formData.append("userfile", fileInputElement.files[0]);

// JavaScript file-like 对象
var content = '<a id="a"><b id="b">hey!</b></a>'; // 新文件的正文...
var blob = new Blob([content], { type: "text/xml"});

formData.append("webmasterfile", blob);

var request = new XMLHttpRequest();
request.open("POST", "http://foo.com/submitform.php");
request.send(formData);
```

> (FormData 对象的字段类型可以是 Blob, File, 或者 string: 如果它的字段类型不是Blob也不是File，则会被转换成字符串类型。

# JQuery form回调函数提交
```js
// 不带文件上传的form回调提交
$("#ajaxform").submit(function(e)
{
    var postData = $(this).serializeArray();
    var formURL = $(this).attr("action");
    $.ajax(
    {
        url : formURL,
        type: "POST",
        data : postData,
        success:function(data, textStatus, jqXHR)
        {
            //data: return data from server
        },
        error: function(jqXHR, textStatus, errorThrown)
        {
            //if fails      
        }
    });
    e.preventDefault(); //STOP default action
    e.unbind(); //unbind. to stop multiple form submit.
});

$("#ajaxform").submit(); //Submit  the FORM
```

```js
// 带文件上传的form回调提交
$("#multiform").submit(function(e)
{
    var formObj = $(this);
    var formURL = formObj.attr("action");
    var formData = new FormData(this);
    $.ajax({
        url: formURL,
        type: 'POST',
        data:  formData,
        mimeType:"multipart/form-data",
        contentType: false,
        cache: false,
        processData:false,
    success: function(data, textStatus, jqXHR)
    {

    },
     error: function(jqXHR, textStatus, errorThrown)
     {
     }          
    });
    e.preventDefault(); //Prevent Default action.
    e.unbind();
});
$("#multiform").submit(); //Submit the form
```
# JQuery FormData对象上传文件

* HTML表单FormData初始化

```js
$.ajax({
  url: 'php/upload.php',
  data: data,
  cache: false,
  contentType: false,
  processData: false,
  type: 'POST',
  success: function(data){
      alert(data);
  }
});
```
> **注意**  
> *contentType：false* //强制JQuery不添加Content-Type头部，否则文件上传的分割线（boundary string）將丢失；
> *processData:false* //如果设置为true JQuery则会將内容转换为string，这是错误的


相关链接：
[https://developer.mozilla.org/zh-CN/docs/Web/API/FormData/Using_FormData_Objects](https://developer.mozilla.org/zh-CN/docs/Web/API/FormData/Using_FormData_Objects)

[https://stackoverflow.com/questions/5392344/sending-multipart-formdata-with-jquery-ajax](https://stackoverflow.com/questions/5392344/sending-multipart-formdata-with-jquery-ajax)
