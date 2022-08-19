# frozen_string_literal: true

class Task < ApplicationRecord
  # Railsを知らなくても読解可能なように敢えてenumは使用しません
  STATUS = { todo: 1, doing: 2, review: 3, completed: 4 }.freeze

  validates :status, inclusion: { in: STATUS.values, message: '存在しないタスクステータスが指定されました' }
  validates :title, presence: { message: 'タイトルを入力してください' }
  validates :description, presence: { message: 'タスク詳細を入力してください' }
  validates :due_date, presence: { message: '期限を入力してください' }
  validate :status_check, on: :update

  private

  def status_check
    # 変更前のステータス
    current_status = attribute_in_database(:status)
    # 変更後のステータス
    # status

    # 更新を中止し、エラーを格納する
    # errors.add(:status, 'エラーメッセージ')
  end
end
