# frozen_string_literal: true

require 'rails_helper'

describe TasksController, type: :request do
  describe 'PATCH #update' do
    subject { put "/tasks/#{task.id}", params: params }
    let!(:params) {
      {
        title: Faker::Book.title,
        status: Task::STATUS[:doing],
        description: Faker::String.random,
        due_date: Faker::Date.between(from: Date.current - 30.days, to: Date.current + 30.days)
      }
    }

    context 'タスクがtodoの場合' do
      let!(:task) { FactoryBot.create(:task, :todo) }

      it 'doingにステータスが変更されること' do
        expect { subject }.to change { Task.find(task.id).status }.from(Task::STATUS[:todo]).to(Task::STATUS[:doing])
      end
    end
  end
end
