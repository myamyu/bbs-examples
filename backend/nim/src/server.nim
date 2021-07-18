import jester, json, strutils, sequtils
import ./private/model
import ./private/service

var
  sv = newBBSService()

routes:
  get "/":
    resp "こんにちはこんにちは"

  # スレッド一覧
  get "/threads":
    let params = request.params
    echo params
    let 
      offset = if params.hasKey("offset"): params["offset"].parseInt else: 0
      limit = if params.hasKey("limit"): params["limit"].parseInt else: 10
      sort = if params.hasKey("sort"): params["sort"] else: "update_desc"
    {.gcsafe.}:
      let list = sv.getThreads(offset, limit, sort)
    resp %*{
      "threadsCount": list.threadsCount,
      "count": list.count,
      "threads": list.threads,
    }

  # スレッド新規作成
  post "/threads":
    let reqBody = parseJson(request.body())
    echo reqBody
    let
      title = if reqBody.hasKey("title"): reqBody["title"].getStr() else: ""
      body = if reqBody.hasKey("body"): reqBody["body"].getStr() else: ""
      authorName = if reqBody.hasKey("name"): reqBody["name"].getStr() else: ""
      tags = if reqBody.hasKey("tags"):
        reqBody["tags"].getElems().map(proc (x:JsonNode):string = x.getStr()) else: @[]

    try:
      {.gcsafe.}:
        var thread = sv.createThread(title, body, authorName, tags)
        resp %thread
    except InvalidException:
      resp Http400, $(%*{
        "error": [
          {"field": "none", "message": "どこかおかしいよ"},
        ],
      }), "application/json"

  # スレッド取得
  get "/threads/@threadId":
    let threadId = @"threadId"
    try:
      {.gcsafe.}:
        let
          thread = sv.getThread(threadId)
          comments = sv.getThreadComments(threadId)
      resp %*{
        "thread": thread,
        "comments": comments,
      }
    except NotFoundException:
      resp Http404, $(%*{
        "message": "見つからないよ",
      }), "application/json"

  # コメント投稿
  post "/threads/@threadId/comments":
    let threadId = @"threadId"
    let reqBody = parseJson(request.body())
    echo reqBody
    let
      body = if reqBody.hasKey("body"): reqBody["body"].getStr() else: ""
      authorName = if reqBody.hasKey("name"): reqBody["name"].getStr() else: ""
      parentCommentId = if reqBody.hasKey("parentComment"): reqBody["parentComment"].getInt() else: 0
    try:
      {.gcsafe.}:
        let
          comment = sv.addComment(threadId, body, authorName, parentCommentId)
      resp %comment
    except NotFoundException:
      resp Http404, $(%*{
        "message": "見つからないよ",
      }), "application/json"

runForever()
