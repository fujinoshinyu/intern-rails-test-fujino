# frozen_string_literal: true

class Task < ApplicationRecord
  # Railsを知らなくても読解可能なように敢えてenumは使用しません
  STATUS = { todo: 1, doing: 2, review: 3, completed: 4 }.freeze


  validates :status, inclusion: { in: STATUS.values, message: '存在しないタスクステータスが指定されました'}
  validates :title, presence: { message: 'タイトルを入力してください' }
  validates :description, presence: { message: 'タスク詳細を入力してください' }
  validates :due_date, presence: { message: '期限を入力してください' }
  validate :status_check, on: :update

  private

  def status_check
    # 変更前のステータス
    logger.debug("変更前のステータスはattribute_in_database(:status)で取得可能です。\n値：#{attribute_in_database(:status)}")
    # 変更後のステータス
    logger.debug("変更後のステータスはstatusで取得可能です。\n値：#{status}")

    # 基本的に値の使い方はrailsコンソールまたはサーバーログへの標準出力で確認しましょう！
    # ex) rails コンソール
    # Running via Spring preloader in process 43
    # Loading development environment (Rails 5.2.8.1)
    # irb(main):001:0> Task::STATUS[:todo]
    # => 1

    # ex) rails実行ログ
    # logger.debugで仕込んだ値がログにでている
    # ステータスが4から2に変更されそうになり、ロールバックしたことがわかる
    # rails-app_1  |    (0.2ms)  BEGIN
    # rails-app_1  |   ↳ app/controllers/tasks_controller.rb:66
    # rails-app_1  | 変更前のステータスはattribute_in_database(:status)で取得可能です。
    # rails-app_1  | 値：4
    # rails-app_1  | 変更後のステータスはstatusで取得可能です。
    # rails-app_1  | 値：2
    # rails-app_1  |    (0.1ms)  ROLLBACK
    # rails-app_1  |   ↳ app/controllers/tasks_controller.rb:66

    # 変更前後でステータスが変わらない場合はチェックの必要がないのでreturn
    return if attribute_in_database(:status) == status

    # 変更前のステータスが
    case attribute_in_database(:status)
    when STATUS[:todo] # TODOの時
      errors.add(:status, 'todoのタスクはdoingのみに変更可能') unless status == STATUS[:doing] # doingでなければエラー
    when STATUS[:doing]
      # doingのタスクはすべてのステータスに変更可能なのでチェックなし
    when STATUS[:review]
      errors.add(:status, 'reviewのタスクはdoingまたはcompletedに変更可能') unless [STATUS[:doing], STATUS[:completed]].include?(status)
    when STATUS[:completed]
      errors.add(:status, 'completedのタスクは他のstatusに変更できません。')
    else
      raise NotImplementedError
    end

    ##個人メモ
    #↓まずは変更前にtodoを取得した場合、次にdoing以外のステータスを取得することができないようにするためのメソッド
    #変数名の代入の際の書き方が分かりませんでした。やりたかったこととしては、STATUSのtodoのみの値を変数名に代入し、todoのみを取得する予定でした。
    # { in: STATUS.todo: 1 }= attribute_in_database(:status)


    #↓次にtodoのステータスが取得された場合、doing以外のステータスは更新できないようにするためのメソッドが必要ということは理解できますが、
    #先ほどと同じく変数の代入とdoing以外でエラー文を表示させるために、「# errors.add(:status, 'エラーメッセージ')」をどう活かせば良いか分かりませんでした。
    # { in: STATUS.todo: 1, STATUS.review: 3, STATUS.completed: 4 } = status(:status)



  # 更新を中止するため、エラーを格納する

    # errors.add(:status, 'エラーメッセージ')
    # errors.add(:status, 'doingのみしか選択できません。')

  end
end


