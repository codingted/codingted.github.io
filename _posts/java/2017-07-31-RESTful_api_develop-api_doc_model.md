---
title:  "接口开发从前到后-文档模板"
categories: java
tags: markdown
comments: true
---

# 文档更新记录

日期        | 更新人   |   更新内容
------------|----------|----------
2017-07-31  |Ted       | 创建论坛接口

# 文档说明

> * 文档需要修改更新记录信息
> * 文档中术语的约定可以在这部分中说明
> * 文档的读者范围
> * 

# 通用返回格式

```
{
    success     : boolean   //成功状态（true:成功，false：失败）
    msg         : string    //消息
}
```

# 错误通用格式

> 该返回的响应最好与[Http状态码](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes)保持一致


```
{
  "error": {
    "code": int,            //错误码(业务状态码)
    "common": string        //错误的通用描述
    "custom": string        //错误的定制化描述（如果需要改变描述）
  }
}
```





# 分页通用格式

```
{
    items:[{
        .....
    }....],
    //以下是分页信息，接口中统一使用PAGE标识
    totalCount      : int       //总条数
    pageSize        : int       //页面条数
    pageCount       : int       //页数
    currentPage     : int       //当前页号
    haveNextPage    : boolean   //是否还有下一页
    havePrePage     : boolean   //是否还有下一页
}
```


# 书籍相关接口

## 添加书籍

> 调用该接口可以添加一本书籍

* 调用方法

```
POST        /books
```

* 输入参数

```
{
    name    :*string    //书名
    desc    :*string    //描述
    ...
}
```

* 输出参数

> [通用返回格式](#通用返回格式)       //这样可以使用部分的（支持中文锚点）Markdown编译出的HTML进行定位

* 错误码

> 无

## 修改书籍

> 调用该接口可以修改书的属性

* 调用方法

```
PUT         /books/{id}
```

* 输入参数

```
{
    id      :*int       //id
    name    :*string    //书名
    desc    :*string    //描述
    ...
}
```

* 输出参数

> [通用返回格式](#通用返回格式)       //这样可以使用部分的（支持中文锚点）Markdown编译出的HTML进行定位

* 错误码

> 无

## 书籍列表

> 调用该接口显示书籍列表

* 调用方法

```
GET         /books
```

* 输入参数

> 无

* 输出参数

```
{
    items:[{
        name    : string    //书名
        desc    : string    //描述
        coverUrl: string    //封面地址
        viewCount: int      //浏览数
        fansCount: int      //粉丝数
        author  : {         //作者信息
            name    : string    //作者的笔名
            homePage: string    //主页地址
        }
        ...
    },...]
    PAGE    //分页信息(参见分页信息)
}
```

* 错误码

```
{
    1   :   //权限不允许
    102 :   //用户不存在
}
```


# 系统错误码 

HTTP状态码  |系统状态码     |说明
------------|---------------|----
500         |0              |系统异常
403         |1              |权限不允许
403         |100            |用户未登录
404         |102            |用户不存在
