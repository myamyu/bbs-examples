# docs

いろんな言語で実装していく掲示板です。

## 掲示板の概要

- 認証なしの匿名掲示板にする
- 掲示板はスレッド式
- 書き込みに対して返信が可能
- スレッドに対してタグを複数（0-N）つけられる
- スレッドは、タイトル・内容・タグ
- スレッドコメントは内容のみ
- HTMLタグは使えない
- 検索はタイトル・内容・タグ・コメント・ユーザーを対象に

## 掲示板APIの仕様

- [OpenAPIの定義ファイル（apis.yaml）](./api/v1/apis.yaml)
