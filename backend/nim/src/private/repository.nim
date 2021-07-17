import uuids, times
import ./model

type
  # RepositoryのI/F
  IBBSRepository* = tuple
    getThreads: proc(offset:int, limit:int, sort:string):ThreadList
    createThread: proc(title:string, body:string, authorName:string, tags:seq[string]):Thread
    getThread: proc(threadId:string):Thread
    addComment: proc(threadId:string, body:string, authorName:string, parentCommendId:int):Comment
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
    threadsCount: 3,
    start: offset,
    count: 3,
    threads: @[
      Thread(
        threadId: $(genUUID()),
        title: "たいとる",
        body: "ぼでー",
        authorName: "ふが次郎",
        tags: @["たぐ"],
        creationTime: now(),
        updateTime: now(),
      ),
      Thread(
        threadId: $(genUUID()),
        title: "たいとる2",
        body: "ぼでー2",
        authorName: "ふが次郎2",
        tags: @["たぐ", "たぐ2"],
        creationTime: now(),
        updateTime: now(),
      ),
      Thread(
        threadId: $(genUUID()),
        title: "たいとる3",
        body: "ぼでー3",
        authorName: "ふが次郎3",
        tags: @["たぐaaaa"],
        creationTime: now(),
        updateTime: now(),
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
    creationTime: now(),
    updateTime: now(),
  )

proc getThread(self:MockBBSRepository, 
    threadId:string):Thread =
  result = Thread(
    threadId: threadId,
    title: "たいとるたいとるたいとる",
    body: "スレッドの内容だよ",
    authorName: "ほげ太郎",
    tags: @["たぐ", "たぐ２"],
    creationTime: now(),
    updateTime: now(),
  )

proc addComment(self:MockBBSRepository, 
    threadId:string, body:string, authorName:string, parentCommendId:int):Comment =
  result = Comment(
    threadId: threadId,
    commentId: parentCommendId + 1,
    body: body,
    authorName: authorName,
    parentCommentId: parentCommendId,
    creationTime: now(),
  )

proc getThreadComments(self:MockBBSRepository, 
    threadId:string):seq[Comment] =
  result = @[
    Comment(
      threadId: threadId,
      commentId: 1,
      body: "コメント1",
      authorName: "米の助",
      parentCommentId: 0,
      creationTime: now(),
    ),
    Comment(
      threadId: threadId,
      commentId: 2,
      body: "コメント2",
      authorName: "米の助",
      parentCommentId: 0,
      creationTime: now(),
    ),
    Comment(
      threadId: threadId,
      commentId: 3,
      body: "コメント3",
      authorName: "米の助",
      parentCommentId: 1,
      creationTime: now(),
    ),
  ]

proc toInterface*(self:MockBBSRepository):IBBSRepository =
  return (
    getThreads: proc(offset:int, limit:int, sort:string):ThreadList =
      self.getThreads(offset, limit, sort),
    createThread: proc(title:string, body:string, authorName:string, tags:seq[string]):Thread =
      self.createThread(title, body, authorName, tags),
    getThread: proc(threadId:string):Thread =
      self.getThread(threadId),
    addComment: proc(threadId:string, body:string, authorName:string, parentCommendId:int):Comment =
      self.addComment(threadId, body, authorName, parentCommendId),
    getThreadComments: proc(threadId:string):seq[Comment] =
      self.getThreadComments(threadId),
  )
