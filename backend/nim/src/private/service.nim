import ./model
import ./repository
import ./dicon

type
  BBSService* = ref object
    repo:IBBSRepository

type
  BBSException* = ref object of CatchableError
  InvalidErrorFields* = ref object
    field*:string
    message*:string
  InvalidException* = ref object of BBSException
    errors*:seq[InvalidErrorFields]
  NotFoundException* = ref object of BBSException

#[
  BBSServiceを作成
]#
proc newBBSService*():BBSService =
  result = BBSService(repo:di.bbsRepository)

#[
  Threadの一覧を取得
]#
proc getThreads*(self:BBSService,
    offset:int, limit:int, sort:string):ThreadList =
  result = self.repo.getThreads(offset, limit, sort)

#[
  あたらしいThreadを作成
]#
proc createThread*(self:BBSService,
    title:string, body:string, authorName:string, tags:seq[string]):Thread =
  # バリデーション
  var invalid = newSeq[InvalidErrorFields]()
  if title == "":
    invalid.add(InvalidErrorFields(
      field: "title",
      message: "タイトルが指定されていません",
    ))
  if body == "":
    invalid.add(InvalidErrorFields(
      field: "body",
      message: "内容が指定されていません",
    ))
  if authorName == "":
    invalid.add(InvalidErrorFields(
      field: "name",
      message: "名前が指定されていません",
    ))

  if invalid.len > 0:
    raise InvalidException(errors:invalid)

  result = self.repo.createThread(title, body, authorName, tags)

#[
  Threadを取得
]#
proc getThread*(self:BBSService,
    threadId:string):Thread =
  result = self.repo.getThread(threadId)
  if result == nil:
    raise NotFoundException()

#[
  Threadにコメントを追加
]#
proc addComment*(self:BBSService,
    threadId:string, body:string, authorName:string, parentCommendId:int):Comment =
  if self.getThread(threadId) == nil:
    raise NotFoundException()
  # バリデーション
  var invalid = newSeq[InvalidErrorFields]()
  if body == "":
    invalid.add(InvalidErrorFields(
      field: "body",
      message: "内容が指定されていません",
    ))
  if authorName == "":
    invalid.add(InvalidErrorFields(
      field: "name",
      message: "名前が指定されていません",
    ))

  if invalid.len > 0:
    raise InvalidException(errors:invalid)

  result = self.repo.addComment(threadId, body, authorName, parentCommendId)

#[
  Threadに紐づくコメントの一覧を取得
]#
proc getThreadComments*(self:BBSService,
    threadId:string):seq[Comment] =
  if self.getThread(threadId) == nil:
    raise NotFoundException()
  result = self.repo.getThreadComments(threadId)
