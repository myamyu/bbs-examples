import jester, json
import marshal
import ./private/model
import ./private/service

var
  sv = newBBSService()

routes:
  get "/":
    resp "こんにちはこんにちは"

  # スレッド一覧
  get "/threads":
    # TODO queryStringから値を取る
    let 
      offset = 0
      limit = 10
      sort = "creation_desc"
    {.gcsafe.}:
      let list = sv.getThreads(offset, limit, sort)
    resp %*{
      "threadsCount": list.threadsCount,
      "count": list.count,
      "threads": $$list.threads,
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
    echo threadId
    resp Http404, $(%*{
      "message": "見つからないよ",
    }), "application/json"

  # コメント投稿
  post "/threads/@threadId/comments":
    let threadId = @"threadId"
    echo threadId
    resp Http404, $(%*{
      "message": "見つからないよ",
    }), "application/json"

runForever()
