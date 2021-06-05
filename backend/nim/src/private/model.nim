import times

type
  Article* = ref object of RootObj
    body:string
    authorName:string
    creationTime:DateTime
    deleteTime:DateTime
  Comment* = ref object of RootObj
    threadId:string
    commentId:int
    parentCommentId:int
  Thread* = ref object of RootObj
    threadId:string
    title:string
    tags:seq[string]
    updateTime:DateTime

