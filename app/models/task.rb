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
    logger.debug("変更前のステータスはattribute_in_database(:status)で取得可能です。値：#{attribute_in_database(:status)}")
    # 変更後のステータス
     logger.debug("変更後のステータスはstatusで取得可能です。\n値:#{status}")



    ##個人メモ
    #↓まずは変更前にtodoを取得した場合、次にdoing以外のステータスを取得することができないようにするためのメソッド
    { in: STATUS.todo: 1 } = attribute_in_database(:status) #←変数をどういった記述で代入すれば良いか分かりませんでした。

    #変数名の代入の際の書き方が分かりませんでした。やりたかったこととしては、STATUSのtodoのみの値を変数名に代入し、todoのみを取得する予定でした。
    #またSTATUS.will_save_change_to_attribute?("status")=>true/falseで指定したカラム（ステータス）に対してtrueかfalseを返し、エラーを発生させることも考えましたが、コーディングが困難でした。

    


    #↓次にtodoのステータスが取得された場合、doing以外のステータスは更新できないようにするためのメソッドが必要ということは理解できますが、
    { in: STATUS.todo: 1, STATUS.review: 3, STATUS.completed: 4 } = status(:status) #←変数をどういった記述で代入すれば良いか分かりませんでした
     #先ほどと同じく変数の代入とdoing以外でエラー文を表示させるために、「# errors.add(:status, 'エラーメッセージ')」をどう活かせば良いか分かりませんでした。




  # 更新を中止するため、エラーを格納する

    # errors.add(:status, 'エラーメッセージ')
    errors.add(:status, 'doingのみしか選択できません。')

  end
end


