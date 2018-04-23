## Using mappings to define kinds of documents

Each document belongs to a type, which in turn belongs to an index. As a logical divi-
sion of data, you can think of *indices as databases and types as tables*.


> **Types provide only logical separation**
With Elasticsearch, there’s no physical separation of documents that have different types. All documents within the same Elasticsearch index, regardless of type, end up in the same set of files belonging to the same shards. In a shard, which is a Lucene index, the name of the type is a field, and all fields from all mappings come together as fields in the Lucene index.

The concept of a type is a layer of abstraction specific to Elasticsearch but not Lucene, which makes it easy for you to have different kinds of documents in the same index. Elasticsearch takes care of separating those documents; for example, by filtering documents belonging to a certain type when you search in that type only.

This approach creates a problem when the same field name occurs in multiple types.  To avoid unpredictable results, two fields with the same name should have the same settings; otherwise Elasticsearch might have a hard time figuring out which of the two fields you’re referring to. In the end, both those fields belong to the same Lucene index. For example, if you have a name field in both group and event documents, both should be strings, not one a string and one an integer. This is rarely a problem in real life, but it’s worth remembering to avoid surprises.

![Using types to divide data in the same index](./img/type_in_index.png)

### Retrieving and defining mappings

* GETTING THE CURRENT MAPPING

```bash
$ curl 'localhost:9200/get-together/group/_mapping?pretty'
```

*  Getting an automatically generated mapping

```bash
$ curl -XPUT 'localhost:9200/get-together/new-events/1' -d '{
    "name": "Late Night with Elasticsearch",
        "date": "2013-10-25T19:00"
}'

$ curl 'localhost:9200/get-together/_mapping/new-events?pretty'

```

> mapping info

```json
{
    "get-together" : {
        "mappings" : {
            "new-events" : {
                "properties" : {
                    "date" : {
                        "type" : "date"
                    },
                    "name" : {
                        "type" : "text",
                        "fields" : {
                            "keyword" : {
                                "type" : "keyword",
                                "ignore_above" : 256
                            }
                        }
                    }
                }
            }
        }
    }
}

```

* DEFINING A NEW MAPPING

```bash
$ curl -XPUT 'localhost:9200/get-together/new-events/1' -d '{
     "name": "Late Night with Elasticsearch",
         "date": "2013-10-25T19:00"
 }'

```
如果重新定义已经存在的mapping中的字段的类型, 是会报错的, 因为如果改变字段的数据类型需要进行:
1. 移除type所有的数据
2. 加入新的mapping
3. 重新为数据索引

To understand why re-indexing might be required, imagine you’ve already indexed an event with a string in the host field. If you want the host field to be long now, Elasticsearch would have to change the way host is indexed in the existing document. As you’ll explore later in this chapter, editing an existing document implies deleting and indexing again. To define correct mappings that hopefully will only need additions, not changes, let’s look at the core types you can choose for your fields in Elasticsearch and what you can do with them.

## 数据类型

string/numeric/date/boolean

### mapping的properties设置index属性

```bash
 curl -XPUT 'localhost:9200/get-together/_mapping/new-events' -d '{
     "new-events" : {
         "properties" : {
             "name": {
                 "type" : "string",
                     "index" : "not_analyzed"
             }
         }
     }
 }'
```
> index的三种参数

* analyzed:解析该字段按照分词规则生成多个term(默认)
* not_analyzed:不解析该字段, 以该字段整体为一个term
* no : 跳过分词没有term产生

