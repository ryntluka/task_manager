class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = Task.new
  end

  def index
    @pagy, @tasks = pagy(current_user.tasks.order(:id), items: 12)
  end

  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def create
    @task = Task.new(task_params)
    @task.is_done = false
    if @task.save
      redirect_to tasks_url, flash: {success: t('the_task_was_saved_successfully')}
    else
      render :new
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    @task.destroy
    redirect_to tasks_url, flash: {warning: t(:the_task_has_been_removed)}
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

  def active
    @pagy, @tasks = pagy(current_user.tasks.select {|task| not task.is_done })
    redirect_to tasks_url
  end

  def finished
    # @tasks = current_user.tasks.select {|task| task.is_done }
    redirect_to tasks_url
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :user_id, :project_id)
  end

end
