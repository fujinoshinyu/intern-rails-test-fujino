# frozen_string_literal: true

class Task < ApplicationRecord
  # Railsを知らなくても読解可能なように敢えてenumは使用しません
  STATUS = { todo: 1, doing: 2, review: 3, completed: 4 ,maboroshi: 5}.freeze

  validates :status, inclusion: { in: STATUS.values, message: '存在しないタスクステータスが指定されました' }
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

    # 更新を中止するため、エラーを格納する
    
    
    # errors.add(:status, 'エラーメッセージ')
  end
end
