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

- ブラウザでrailsアプリの動作確認をする

http://localhost:3000/tasks

- (dockerコンテナの起動中に) railsコンソール

`docker-compose exec rails-app rails c`

- ログ確認

`docker-compose up`を実行したターミナルにログが出ます。
log配下にrailsログが出力されているのでそちらでも確認できます。

Linux / Mac の場合
`tail -f log/development.log`

# 課題
適切な変数名を用い、必要に応じてメソッドやクラスを定義してください

## 課題1
app/models/task.rbの以下のメソッドについて、要件を満たすように拡張してください

```ruby
# 引数には変更したいstatusがIntegerで渡される
def update_status(status)
    #課題１
    
    update(status: status)
end
```

動作確認

http://localhost:3000/tasks/1

このページのステータス更新機能を拡張してもらいます。

### 要件

現状tasksテーブルのstatusカラム(Integer)は上記ページから好きなステータスに変更可能である。
それを以下のような要件に変更する。

tasksテーブルのstatusカラム(Integer)は、ステータス遷移にルールがある。<br>
  ( todo：1, doing：2, review：3, completed：4 )<br>

* todoのタスクはdoingにのみ遷移できる。
* doingのタスクはtodoとreview、completedに遷移できる。
* reviewのタスクはdoing、completedに遷移できる。
* completedのタスクは他のstatusに遷移できない。
* これらのルールにそぐわなかった場合、メソッド内で以下を実行してupdateを中断する。<br>
  ※以下のメソッドを実行すると、updateは行われず画面上にエラーメッセージが表示される。<br>
  `errors.add(:status, 'エラーメッセージ')`


## 課題2

spec/models/tasks_spec.rbに、課題１の要件を満たすテストコードを書いてください<br>
todoのタスクを別のステータスに変える場合のテストは既に実装されているため、参考にしてください

- (dockerコンテナの起動中に) テストコードの実行<br>
`docker-compose exec rails-app rspec`

## 課題3

WIP: 検索機能

## 課題4

下記コードには、あまり適切ではない構造・書き方の部分があります。<br>
どこに問題があると思われるか、このREADMEに記述してください

WIP
```ruby
class Hoge
end

class Fuga

end
```

<回答欄><br>
この～は、、、、～なので、、、、。