class TasksController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def new
    @task = Task.new
  end

  def index
    @tasks_list = current_user.tasks.order(:id)
    @search = params["search"]
    @done = params["done"]
    if @search.present?
      @title = @search["title"]
      @tasks_list = @tasks_list.search_by_title(@title)
    end
    if @done.present?
      @tasks_list = @tasks_list.filter_by_done(@done)
    end
    @tasks = @tasks_list
    # @pagy, @tasks = pagy(@tasks_list, items: 12)
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

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update(task_params)
    redirect_to task_path(@task), flash: {success: t('the_task_was_saved_successfully')}
  end

  def do
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = true
    @task.save
    logger.debug("UNDO")
    logger.debug(@task)
  end

  def undo
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = false
    @task.save
    logger.debug("UNDO")
    logger.debug(@task)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :user_id, :project_id)
  end

  def index_params
    params.permit :done
  end

end
