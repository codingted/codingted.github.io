---
layout: post
title:  "AWK内建变量FS,OFS,RS,ORS,NR,NF,FNR"
categories: linux
tags: linux awk
comments: true
---

* content
{:toc}

awk是个优秀文本处理工具，可以说是一门程序设计语言。下面是awk内置变量。






## FS(input Filed Seprator)

默认的Awk读入文本每一行是一条记录,使用空白符号(空格,\t)进行分割,然后將每个分割的部分设置为$1,$2... .FS是用来定义记录的分割符的变量(可以是字符或者表达式).

使用方法:

* 使用-F参数
* 定义FS变量

```
#语法
awk -F 'FS' 'command' inputfile

或者

awk 'BEGIN{FS="FS";}'
```



```
$ cat etc_passwd.awk

BEGIN{
FS=":";
print "Name\tUserId\tGroupId\tHomeDir";
}
{
    print $1"\t"$2"\t"$3"\t"$6;
}
END{
    print NR,"Records processed";
}

```

输出结果

```
% awk -f etc_passwd.awk /etc/passwd 
Name	UserId	GroupId	HomeDir
root	x	0	/root
daemon	x	1	/usr/sbin
bin	x	2	/bin
sys	x	3	/dev
sync	x	4	/bin
...
44 Records processed
```

## OFS(Output Field Seperator)

设置输出内容之间的分割符

```
$ awk -F ':' '{print $1,$2}' /etc/passwd

root x
daemon x
bin x
```

默认的$1和$2之间的分割符是空白符,如果想使用其它的分割符需要进行定义

```
$ awk -F ':' 'BEGIN{OFS="->";}{print $1,$2;}' /etc/passwd
root->x
daemon->x
bin->x
```

## RS(Record Seperator)

默认的每一个回车换行是一条记录,如果我们需要查看的记录为这种格式:

```
$cat student.txt
Jones
2143
78
84
77

Gondrol
2321
56
58
45

RinRao
2122
38
37
65

Edwin
2537
78
67
45

Dayan
2415
30
47
20
```

下边的awk脚本將按照每个学生为一条记录进行解析,当然需要告诉awk每一条记录的分割符

```
$ awk 'BEGIN{RS="\n\n"; FS="\n";} {print $1,$2;}' student.txt

Jones 2143
Gondrl 2321
RinRao 2122
Edwin 2537
Dayan 2415
```

## ORS(Out Record Seperator)

```
$ awk 'BEGIN{ORS="->";} {print $1,$2}' student.txt

Jones 2143->Gondrl 2321->RinRao 2122->Edwin 2537->Dayan 2415

```

## NR(Number of Records)

记录处理记录的总数量

```
$ awk 'BEGIN{RS="\n\n";FS="\n"} {print $1,$2, "\tNo ", NR} END {print NR, "student processed"}' students.txt

Jones 2143 	    No  1
Gondrol 2321 	No  2
RinRao 2122 	No  3
Edwin 2537 	    No  4
Dayan 2415 	    No  5
5 student processed
```
## NF(Number of Fields)

每条记录分割完成后的字段数量

```
% awk 'BEGIN{RS="\n\n";FS="\n"} {print $1, "\tfields->", NF}' students.txt   
Jones 	fields-> 5
Gondrol 	fields-> 5
RinRao 	fields-> 5
Edwin 	fields-> 5
Dayan 	fields-> 5
```
## FILENAME

```
% awk 'BEGIN{RS="\n\n";FS="\n"} END{print FILENAME, " has ", NR, "Records"}' students.txt  
students.txt  has  5 Records
```

## FNR(File Number of Records) 

当awk 读入多个文件时 NR记录的是总的记录数,如果想要记录每个文件的记录数,则使用FNR
