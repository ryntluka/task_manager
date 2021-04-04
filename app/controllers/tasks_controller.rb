class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.new
  end

  def index
    @tasks = current_user.tasks
  end

    def show
      @task = current_user.tasks.find_by(id: params[:id])
    end

  def create
    @task = Task.new(task_params)
    @task.is_done = false
    if @task.save
      redirect_to tasks_url
    else
      @error = @task.errors
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    if @task.destroy
      redirect_to tasks_url
    end
  end

  def do
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = true
    @task.save
    redirect_to tasks_url
  end

  def undo
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = false
    @task.save
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :user_id, :project_id)
  end

end
