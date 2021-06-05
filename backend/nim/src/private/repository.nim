import ./model

type
  # RepositoryのI/F
  BBSRepository* = tuple
    getThreads: proc(offset:int, limit:int, sort:string):ThreadList
    createThread: proc(title:string, body:string, authorName:string, tags:seq[string]):Thread
    getThread: proc(threadId:string):Thread
    addComment: proc(threadId:string, body:string, authorName:string, parentCommendId:ref int):Comment
    getThreadComments: proc(threadId:string):seq[Comment]
