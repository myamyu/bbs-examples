# Database

掲示板用のDBを構築するためのDockerfileと初期化DDLなどです。

## 使用方法

※ database名などを変えたい場合は[docker-compose.yaml](./docker-compse.yaml)を適宜変えてください。

```bash
docker-compose up -d --build
```

```bash
docker ps
```
で立ち上がっていることを確認。

bashで中に入るときは
```bash
docker-compose exec bbs-db bash
```

psqlを使いたいときはそのまま叩いちゃってOK
```bash
docker-compose exec bbs-db psql -U bbs
```
