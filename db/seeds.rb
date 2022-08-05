# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
4.times do |n|
  Task.create!(
    title: "タスク#{n}",
    description: "タスク#{n}の作業の説明です",
    due_date: Date.current + rand(1..30).days,
    status: n + 1
  )
end
