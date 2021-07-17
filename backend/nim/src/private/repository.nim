import uuids
import ./model

type
  # RepositoryのI/F
  IBBSRepository* = tuple
    getThreads: proc(offset:int, limit:int, sort:string):ThreadList
    createThread: proc(title:string, body:string, authorName:string, tags:seq[string]):Thread
    getThread: proc(threadId:string):Thread
    addComment: proc(threadId:string, body:string, authorName:string, parentCommendId:ref int):Comment
    getThreadComments: proc(threadId:string):seq[Comment]
  # Mock版のリポジトリ
  MockBBSRepository* = ref object

#[
  モック版のリポジトリを作成
]#
proc newMockBBSRepository*():MockBBSRepository =
  return MockBBSRepository()

proc getThreads(self:MockBBSRepository, 
    offset:int, limit:int, sort:string):ThreadList =
  result = ThreadList(
    threadsCount: 10,
    start: offset,
    count: limit,
    threads: @[
      Thread(
        threadId: $(genUUID()),
        title: "たいとる",
        body: "ぼでー",
        authorName: "ふが次郎",
        tags: @["たぐ"],
      ),
    ]
  )

proc createThread(self:MockBBSRepository,
    title:string, body:string, authorName:string, tags:seq[string]):Thread =
  result = Thread(
    threadId: $(genUUID()),
    title: title,
    body: body,
    authorName: authorName,
    tags: tags,
  )

proc getThread(self:MockBBSRepository, 
    threadId:string):Thread =
  result = Thread(
    threadId: threadId,
    title: "たいとるたいとるたいとる",
    body: "スレッドの内容だよ",
    authorName: "ほげ太郎",
    tags: @["たぐ", "たぐ２"],
  )

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
