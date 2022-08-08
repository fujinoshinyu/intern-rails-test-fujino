# intern-rails-test
インターン採用でのスキルチェック

# 開発環境
## Docker Desktopの導入

dockerを使用したことがない方は導入してください

https://www.docker.com/products/docker-desktop/

## 初期構築

- dockerコンテナのbuild

`docker-compose build`

- DBの設定

`docker-compose run rails-app rails db:create db:migrate db:seed`

## 開発時
- dockerコンテナの起動

`docker-compose up`

- (dockerコンテナの起動時に) railsコンソール

`docker-compose exec rails-app rails c`

- ログ確認

docker-compose upを実行したターミナルにログが出ます。
log配下にrailsログが出力されているのでそちらでも確認できます。

Linux/Mac の場合
`tail -f log/development.log`

# 課題

## 課題1
app/models/task.rbの以下のメソッドについて、要件を満たすように拡張してください

```ruby
def update_status(status)
    #課題１

    update!(status: status)
    false
  end
```
### 要件
