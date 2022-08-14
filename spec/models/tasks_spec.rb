# frozen_string_literal: true

require 'rails_helper'

describe Task, type: :model do
  describe '#update_status' do
    # テスト対象のメソッド
    # taskとstatusは下で定義される
    subject { task.update_status(status) }

    context 'タスクがtodoの場合' do
      # todoのタスクを作成
      let!(:task) { FactoryBot.create(:task, :todo) }

      context '引数にdoingの数字(2)を渡すと' do
        # todoのタスクを作成
        let!(:status) { Task::STATUS[:doing] }

        it 'todo(1)からdoing(2)にステータスが変更される' do
          # subjectでテスト対象のメソッドを実行
          # Task.find(task.id).statusがテスト対象メソッドの実行前後でTask::STATUS[:todo]からTask::STATUS[:doing]になることを確認
          expect { subject }.to change { Task.find(task.id).status }.from(Task::STATUS[:todo]).to(Task::STATUS[:doing])
        end
      end

      context '引数にreviewの数字（3）を渡すと' do
        let!(:status) { Task::STATUS[:review] }

        it 'reviewステータスには遷移せず、値は更新されない' do
          # subjectでテスト対象のメソッドを実行
          subject
          # Task.find(task.id).statusがtodoであることを確認
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

    context 'タスクがdoingの場合' do
      let!(:task) { FactoryBot.create(:task, :doing) }
    end
  end
end
