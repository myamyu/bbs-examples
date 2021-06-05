import times

type
  Article* = object
    body:string
    authorName:string
    creationTime:DateTime
    deleteTime:ref DateTime
  Comment* = object
    threadId:string
    commentId:int
    parentCommentId:ref int
  Thread* = object
    threadId:string
    title:string
    tags:seq[string]
    updateTime:DateTime
  ThreadList* = object
    threadsCount:int
    start:int
    count:int
    threads:seq[Thread]

#[
  Articleが削除されているか？
]#
proc isDelete*(a:Article):bool = a.deleteTime != nil
