---
title:  "AWK内建变量FS,OFS,RS,ORS,NR,NF,FNR"
categories: linux
tags: linux awk
comments: true
---

awk是个优秀文本处理工具，可以说是一门程序设计语言。下面是awk内置变量。


<!-- more -->


## FS(input Filed Seprator)

默认的Awk读入文本每一行是一条记录,使用空白符号(空格,\t)进行分割,然后將每个分割的部分设置为$1,$2... .FS是用来定义记录的分割符的变量(可以是字符或者表达式).

使用方法:

* 使用-F参数
* 定义FS变量

```shell
#语法
awk -F 'FS' 'command' inputfile

多个分割符使用[]，例如：    
awk -F '[:\t]' 'commond' inputfile

或者

awk 'BEGIN{FS="FS";}'
```


```shell
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

```shell
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

```shell
$ awk -F ':' '{print $1,$2}' /etc/passwd

root x
daemon x
bin x
```

默认的$1和$2之间的分割符是空白符,如果想使用其它的分割符需要进行定义

```shell
$ awk -F ':' 'BEGIN{OFS="->";}{print $1,$2;}' /etc/passwd
root->x
daemon->x
bin->x
```

## RS(Record Seperator)

默认的每一个回车换行是一条记录,如果我们需要查看的记录为这种格式:

```shell
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

```shell
$ awk 'BEGIN{RS="\n\n"; FS="\n";} {print $1,$2;}' student.txt

Jones 2143
Gondrl 2321
RinRao 2122
Edwin 2537
Dayan 2415
```

## ORS(Out Record Seperator)

```shell
$ awk 'BEGIN{ORS="->";} {print $1,$2}' student.txt

Jones 2143->Gondrl 2321->RinRao 2122->Edwin 2537->Dayan 2415

```

## NR(Number of Records)

记录处理记录的总数量

```shell
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

```shell
% awk 'BEGIN{RS="\n\n";FS="\n"} {print $1, "\tfields->", NF}' students.txt   
Jones 	fields-> 5
Gondrol 	fields-> 5
RinRao 	fields-> 5
Edwin 	fields-> 5
Dayan 	fields-> 5
```
## FILENAME

```shell
% awk 'BEGIN{RS="\n\n";FS="\n"} END{print FILENAME, " has ", NR, "Records"}' students.txt  
students.txt  has  5 Records
```

## FNR(File Number of Records) 

当awk 读入多个文件时 NR记录的是总的记录数,如果想要记录每个文件的记录数,则使用FNR
 
## awk内置变量

变量名      | 含义
------------|---------
ARGC        | 命令行参数的数目
ARGIND      | 命令行中当前的文件在ARGV内的索引（仅用于gawk）
ARGV        | 命令行参数数组
CONVFMT     | 数字转换格式，默认%.6g(仅用于gawk)
ENVIRON     | 包含当前shell环境变量值的数组
ERRNO       | 在使用`getline`进行读取操作或者是`close`进行系统重定向时，如果发生错误，ERRNO会包含错误描述（仅用于gawk）
FIELDWIDTHS | `echo "aabbbcccc" | awk -v FIELDWIDTHS="2 3 4" '{for(i=1;i<=NF;i++)print $i}'`
FILENAME    | 当前输入文件的名称
FNR         | 当前文件记录数（与NR的区别是，当输入多个文件时会分别显示每个文件中的记录数）
FS          | 输入字段分割符，默认空格
IGNORECASE  | 正则表达式或字符串匹配中不区分大小写,非0值时忽略大小写（仅用与gawk）
NF          | 当前记录的字段数
NR          | 目前的记录数
OFMT        | 数字的输出格式
OFS         | 输出字段分割符
ORS         | 输出记录分割符
RLENGTH     | match函数匹配到的字符串的长度
RS          | 输入记录分割符
RSTART      | match函数匹配到的字符串的偏移量
RT          | 
SUBSEP      | 数组下表分割符
