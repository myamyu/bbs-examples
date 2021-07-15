import ./model

type
  # RepositoryのI/F
  IBBSRepository* = tuple
    getThreads: proc(offset:int, limit:int, sort:string):ThreadList
    createThread: proc(title:string, body:string, authorName:string, tags:seq[string]):Thread
    getThread: proc(threadId:string):Thread
    addComment: proc(threadId:string, body:string, authorName:string, parentCommendId:ref int):Comment
    getThreadComments: proc(threadId:string):seq[Comment]
  MockBBSRepository* = ref object
    threads: seq[Thread]
    comments: seq[Comment]

#[
  モック版のリポジトリを作成
]#
proc newMockBBSRepository*():MockBBSRepository =
  return MockBBSRepository(
    threads:newSeq[Thread](),
    comments:newSeq[Comment]())

proc getThreads(self:MockBBSRepository, 
    offset:int, limit:int, sort:string):ThreadList =
  return ThreadList()

proc createThread(self:MockBBSRepository,
    title:string, body:string, authorName:string, tags:seq[string]):Thread =
  return Thread()

proc getThread(self:MockBBSRepository, 
    threadId:string):Thread =
  return Thread()

proc addComment(self:MockBBSRepository, 
    threadId:string, body:string, authorName:string, parentCommendId:ref int):Comment =
  return Comment()

proc getThreadComments(self:MockBBSRepository, 
    threadId:string):seq[Comment] =
  return newSeq[Comment]()

proc toInterface*(self:MockBBSRepository):IBBSRepository =
  return (
    getThreads: proc(offset:int, limit:int, sort:string):ThreadList =
      self.getThreads(offset, limit, sort),
    createThread: proc(title:string, body:string, authorName:string, tags:seq[string]):Thread =
      self.createThread(title, body, authorName, tags),
    getThread: proc(threadId:string):Thread =
      self.getThread(threadId),
    addComment: proc(threadId:string, body:string, authorName:string, parentCommendId:ref int):Comment =
      self.addComment(threadId, body, authorName, parentCommendId),
    getThreadComments: proc(threadId:string):seq[Comment] =
      self.getThreadComments(threadId),
  )
