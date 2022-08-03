class Task < ApplicationRecord
  # Railsを知らなくても読解可能なように敢えてenumは使用しません
  STATUS = { todo: 1, doing: 2, review: 3, completed: 4}

  validates :status, inclusion: { in: STATUS.values }

  def doing!
    self.status = STATUS[:todo]
  end


  def reviewable?
    status == STATUS[:doing]
  end

  def review!
    if reviewable?
      self.status = STATUS[:review]
    else
      errors.add(:status, 'doingのタスクしかreviewにはできません')
    end
  end

  def in_progress?
    # ここ課題にする？
    status == STATUS[:doing] || status == STATUS[:review]
  end

  def completed!
    if in_progress?
      self.status = STATUS[:completed]
    else
      errors.add(:status, '作業中のタスクしか完了にできません')
    end
  end
end
