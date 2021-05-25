import jester, json

routes:
  get "/":
    resp "こんにちはこんにちは"

  # スレッド一覧
  get "/threads":
    resp %*{
      "threadsCount": 0,
      "count": 0,
      "threads": [],
    }

  # スレッド新規作成
  post "/threads":
    let reqBody = parseJson(request.body())
    echo reqBody
    resp Http400, $(%*{
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
