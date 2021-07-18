import jester, json, strutils
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
    resp Http503, $(%*{
      "error": [
        {"field": "none", "message": "まだできてません"},
      ],
    }), "application/json"

  # スレッド取得
  get "/threads/@threadId":
    let threadId = @"threadId"
    {.gcsafe.}:
      # TODO threadがなかったら404
      let
        thread = sv.getThread(threadId)
        comments = sv.getThreadComments(threadId)
    resp %*{
      "thread": thread,
      "comments": comments,
    }

  # コメント投稿
  post "/threads/@threadId/comments":
    let threadId = @"threadId"
    echo threadId
    resp Http404, $(%*{
      "message": "見つからないよ",
    }), "application/json"

runForever()
