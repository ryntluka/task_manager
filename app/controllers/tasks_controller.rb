class TasksController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def new
    @task = Task.new
    @task.issues.build
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
    @pagy, @tasks = pagy(@tasks_list, items: 12)
  end

  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def create
    @task = Task.new(task_create_params)
    logger.debug(@task)
    @task.user = current_user
    @task.is_done = false
    if @task.save
      redirect_to tasks_url, flash: {success: t('the_task_was_saved_successfully')}
    else
      flash.now[:danger] = t(:please_review_the_problems_below)
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
    @task.user = current_user
    @task.update(task_update_params)
    redirect_to task_path(@task), flash: {success: t('the_task_was_saved_successfully')}
  end

  def do
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = true
    @task.save
  end

  def undo
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = false
    @task.save
  end

  private

  def task_create_params
    params.require(:task).permit(:title, :description, :project_id, :tag_ids => [])
  end

  def task_update_params
    params.require(:task).permit(:title, :description, :project_id, :is_done, :tag_ids => [])
  end
end
