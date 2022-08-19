# intern-rails-test
インターン採用でのスキルチェック

# 開発環境
このリポジトリを自分のアカウントへ、ForkではなくDuplicateしてください。<br>
必要ならプライベートリポジトリーにしても大丈夫です。<br>
作業はDuplicateした自分のリポジトリで作業を行い、コミット・プッシュしてください。

参考資料
https://docs.github.com/en/repositories/creating-and-managing-repositories/duplicating-a-repository


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

## 課題ルール
* 適切な変数名を用い、必要に応じてメソッドやクラスを定義してください。
* ソースコード上に適宣コメントを残してください。
* インターネットでの検索やコピー＆ペーストは自由にして構いません。
* データベースにtasksテーブルを用意しています。
  * テーブルの詳細は以下マイグレーションファイルを参照してください。
    * db/migrate/20220731083408_create_tasks.rb
  * Railsアプリケーションでは基本的にActive Recordを用いてデータベースの情報を取得・更新します。
    * https://railsguides.jp/active_record_basics.html
    * 今回の場合はActiveRecordを継承したTaskモデル（クラス）を用意しているので活用してください。
  


このコーディングテストでは、元の知識が豊富か・課題を完璧に解けるかということよりも、<br>
課題やわからないものに対してどうアプローチするかに重点を置いています。<br>
完成しなかった場合でも、どう考えたか・何をインプットしたかはコメントを残すようにしてください。


## 課題1
app/models/task.rbのstatus_checkメソッドについて、要件を満たすように拡張してください。


動作確認

http://localhost:3000/tasks/1

このページのステータス更新機能を拡張してもらいます。

### 要件

現状tasksテーブルのstatusカラム(Integer)は上記ページから好きなステータスに変更可能である。<br>
それを以下のような要件に変更する。

tasksテーブルのstatusカラム(Integer)は、ステータス遷移にルールがある。<br>
statusの値とステータス名の関係↓<br>
  ( todo：1, doing：2, review：3, completed：4 )<br>

* todoのタスクはdoingにのみ遷移できる。
* doingのタスクはtodoとreview、completedに遷移できる。
* reviewのタスクはdoing、completedに遷移できる。
* completedのタスクは他のstatusに遷移できない。
* これらのルールにそぐわなかった場合、メソッド内で以下を実行してupdateを中断する。<br>
  ※以下のメソッドを実行すると、updateは行われず画面上にエラーメッセージが表示される。<br>
  `errors.add(:status, 'エラーメッセージ')`


## 課題2

spec/models/tasks_spec.rbに、課題１の要件を満たすテストコードを書いてください。<br>
test用のgem（ライブラリ）はrspecを使用しています。<br>
todoのタスクを別のステータスに変える場合のテストは既に実装されているため、参考にしてください。

- (dockerコンテナの起動中に) テストコードの実行<br>
`docker-compose exec rails-app rspec`

## 課題3

http://localhost:3000/tasks

上記URLでアクセス可能なタスク一覧ページの検索機能は未実装です。<br>
app/controllers/tasks_controller.rbのindexメソッドを編集することで検索機能を実装してください。

### 要件
* 検索ワードによって絞り込みが可能。
  * タスクのタイトル、詳細（title, description）で一致するものを取得できる。
  * 難しい場合にはタイトルか詳細の一方だけの検索で構いません
  * 検索ワードは変数`search_words`に代入されています。
  

* タスクの期限（due_date）によっても絞り込みが可能
  * 絞り込みの開始日と終了日を指定して絞り込みができる
  * 開始日のみ入力された場合は開始日以降のタスクが取得できる
  * 終了日のみ入力された場合は終了日以前のタスクが取得できる
  * フロントから受け取った開始日、終了日はそれぞれ`params[:due_date_start]`、`params[:due_date_end]`で取得可能です

* 絞り込みの完了したタスクの配列はインスタンス変数`@tasks`に代入することでページに反映されます。

<br>

### 課題は以上となります。