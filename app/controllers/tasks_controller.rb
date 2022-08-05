# frozen_string_literal: true

class TasksController < ApplicationController
  def index
    @status_filter = params[:status_filter].to_i
    @tasks = @status_filter.zero? ? Task.all : Task.where(status: @status_filter)
  end

  def show
    @task = Task.find(params[:id].to_i)
  rescue StandardError
    redirect_to '/tasks', flash: { danger: 'エラーが発生しました' }
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    @task.save!

    redirect_to "/tasks/#{@task.id}", flash: { success: '作成に成功しました' }
  rescue StandardError => e
    flash[:danger] = "作成に失敗しました。#{e.message}"
    render :new
  end

  def edit
    @task = Task.find(params[:id].to_i)
  rescue StandardError
    redirect_to '/tasks', flash: { danger: 'エラーが発生しました' }
  end

  def update
    @task = Task.find(update_params[:id].to_i)
    @task.update!(update_params)

    redirect_to "/tasks/#{@task.id}", flash: { success: '更新に成功しました' }
  rescue StandardError => e
    flash[:danger] = "更新に失敗しました。#{e.message}"
    render :edit
  end

  def update_status
    status = params[:status].to_i
    task_id = params[:task_id].to_i
    task = Task.find(task_id)

    task.update!(status: status)

    redirect_to "/tasks/#{task.id}", flash: { success: '更新に成功しました' }
  rescue StandardError => e
    redirect_to "/tasks/#{task&.id}", flash: { danger: "更新に失敗しました。error:#{e.full_message}" }
  end

  def destroy
    @task = Task.find(params[:id].to_i)
    @task.delete

    redirect_to '/tasks', flash: { success: '削除に成功しました' }
  rescue StandardError => e
    flash[:danger] = "削除に失敗しました。#{e.message}"
    redirect_to '/tasks'
  end

  private

  def create_params
    params.permit(:title, :status, :description, :due_date)
  end

  def update_params
    params.permit(:id, :title, :status, :description, :due_date)
  end
end
