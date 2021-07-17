import times

type
  Article* = ref object of RootObj
    body*:string
    authorName*:string
    creationTime*:DateTime
    deleteTime*:ref DateTime
  Comment* = ref object of Article
    threadId*:string
    commentId*:int
    parentCommentId*:ref int
  Thread* = ref object of Article
    threadId*:string
    title*:string
    tags*:seq[string]
    updateTime*:DateTime
  ThreadList* = object
    threadsCount*:int
    start*:int
    count*:int
    threads*:seq[Thread]

#[
  Articleが削除されているか？
]#
proc isDelete*(a:Article):bool = a.deleteTime != nil
