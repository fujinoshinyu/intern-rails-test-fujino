require 'rails_helper'

describe TasksController, type: :request do
  describe 'PATCH #update' do
    subject{ put "/tasks/update", params: { task: { status: Task::STATUS[:doing] } } }
    let!(:task) { FactoryBot.create(:task, :todo) }

    context 'タスクがtodoの場合' do
      it 'doingにステータスが変更されること' do
        expect{ subject }.to change{ Task.find(task.id).status }.from(Task::STATUS[:todo]).to(Task::STATUS[:doing])
      end
    end
  end
end
