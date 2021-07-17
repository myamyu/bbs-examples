import times, json

type
  BBSDateTime = DateTime
  Article* = ref object of RootObj
    body*:string
    authorName*:string
    creationTime*:BBSDateTime
    deleteTime*:ref BBSDateTime
  Comment* = ref object of Article
    threadId*:string
    commentId*:int
    parentCommentId*:ref int
  Thread* = ref object of Article
    threadId*:string
    title*:string
    tags*:seq[string]
    updateTime*:BBSDateTime
  ThreadList* = object
    threadsCount*:int
    start*:int
    count*:int
    threads*:seq[Thread]

#[
  Articleが削除されているか？
]#
proc isDelete*(a:Article):bool = a.deleteTime != nil

proc `%`*(dt:BBSDateTime):JsonNode =
  result = %dt.format("yyyy-MM-dd HH:mm:ss")
