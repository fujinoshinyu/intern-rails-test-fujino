# frozen_string_literal: true

require 'rails_helper'

describe Task, type: :model do
  describe '#update_status' do
    subject { task.update_status(status) }

    context 'タスクがtodoの場合' do
      let!(:task) { FactoryBot.create(:task, :todo) }

      context '引数にdoingの数字(2)を渡すと' do
        let!(:status) { Task::STATUS[:doing] }

        it 'todo(1)からdoing(2)にステータスが変更される' do
          expect { subject }.to change { Task.find(task.id).status }.from(Task::STATUS[:todo]).to(Task::STATUS[:doing])
        end
      end

      context '引数にreviewの数字（3）を渡すと' do
        let!(:status) { Task::STATUS[:review] }

        it 'reviewステータスには遷移せず、値は更新されない' do
          subject
          expect(Task.find(task.id).status).to eq(Task::STATUS[:todo])
        end
      end

      context '引数にreviewの数字（4）を渡すと' do
        let!(:status) { Task::STATUS[:completed] }

        it 'completedステータスには遷移せず、値は更新されない' do
          subject
          expect(Task.find(task.id).status).to eq(Task::STATUS[:todo])
        end
      end
    end
  end
end
