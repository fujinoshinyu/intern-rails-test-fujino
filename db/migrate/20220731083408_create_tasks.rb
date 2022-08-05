# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.string :description, null: false, default: ''
      t.integer :status, null: false
      t.date :due_date
      t.timestamps
    end
  end
end
