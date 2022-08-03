class TasksController < ApplicationController
  def index
    @status_filter = params[:status_filter].to_i
    @tasks = @status_filter == 0 ? Task.all : Task.where(status: @status_filter)
  end

  def show
    @task = Task.find(params[:id].to_i)
  end

  def new

  end

  def create

  end

  def edit
  end

  def update

  end

  def update_status
    status = params[:status].to_i
    task_id = params[:task_id].to_i
    task = Task.find(task_id)

    task.update!(status: status)

    redirect_to "/tasks/#{task.id}", flash: {success: "更新に成功しました"}
  rescue e
    redirect_to "/tasks/#{task&.id}", flash: {danger: "更新に失敗しました。error:#{e.full_message}"}
  end

  def delete

  end
end