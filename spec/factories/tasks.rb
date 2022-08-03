FactoryBot.define do
  factory :task, class: Task do
    title { Faker::Book.title }
    description { Faker::String.random }
    due_date { Faker::Date.between(from: 20.days.ago, to: 20.days.from_now) }
    status { 1 }

    # statusを指定するtrait
    # 例）create(:task, :review)
    # →reviewでつくられる
    Task::STATUS.each do |k, v|
      trait :"#{k}" do
        status { v }
      end
    end
  end
end

