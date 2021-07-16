import ./model
import ./repository
import ./dicon

type
  BBSService* = ref object
    repo:IBBSRepository

#[
  BBSServiceを作成
]#
proc newBBSService*():BBSService =
  return BBSService(repo:di.bbsRepository)

#[
  Threadの一覧を取得
]#
proc getThreads*(self:BBSService,
    offset:int, limit:int, sort:string):ThreadList =
  return self.repo.getThreads(offset, limit, sort)

#[
  あたらしいThreadを作成
]#
proc createThread*(self:BBSService,
    title:string, body:string, authorName:string, tags:seq[string]):Thread =
  # TODO バリデーション
  return self.repo.createThread(title, body, authorName, tags)

#[
  Threadを取得
]#
proc getThread*(self:BBSService,
    threadId:string):Thread =
  # TODO thread 存在チェック
  return self.repo.getThread(threadId)

#[
  Threadにコメントを追加
]#
proc addComment*(self:BBSService,
    threadId:string, body:string, authorName:string, parentCommendId:ref int):Comment =
  # TODO thread 存在チェック
  # TODO バリデーション
  return self.repo.addComment(threadId, body, authorName, parentCommendId)

#[
  Threadに紐づくコメントの一覧を取得
]#
proc getThreadComments*(self:BBSService,
    threadId:string):seq[Comment] =
  # TODO thread 存在チェック
  return self.repo.getThreadComments(threadId)
