class TasksController < ApplicationController
  before_action :authenticate_user!
  respond_to :html, :js

  def new
    @task = Task.new
    @task.issues.build
  end

  def index
    tasks_list = current_user.tasks.order(:id)
    @done = params["done"]
    if @done.present?
      if @done == 'true'
        tasks_list = tasks_list.finished
      elsif @done == 'false'
        tasks_list = tasks_list.active
      end
    end
    if params["search"].present?
      @title = params["search"]["title"]
      @tags = params["search"]["tags"]
      if @tags.length > 1
        tasks_list = tasks_list.filter_by_tags(@tags)
        logger.debug(@tags)
        logger.debug("RES")
        logger.debug(tasks_list.count)
      end
      tasks_list = tasks_list.search_by_title(@title)
    end
    @tasks = tasks_list
    @pagy, @tasks = pagy(tasks_list.includes([:project, :issues, :tags]), items: 12)
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
      redirect_to tasks_url, flash: {success: t(:the_task_was_saved_successfully)}
    else
      flash.now[:danger] = t(:please_review_the_problems_below)
      render :new
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    if @task.destroy
      redirect_to tasks_url, flash: {warning: t(:the_task_has_been_removed)}
    else
      logger.debug("Error occured during destroying task")
    end
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.user = current_user
    if @task.update(task_update_params)
      redirect_to task_path(@task), flash: {success: t(:the_task_was_saved_successfully)}
    else
      logger.debug("Error occured during updating task")
    end
  end

  def do
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = true
    unless @task.save
      logger.debug("Error occured during saving task")
    end
  end

  def undo
    @task = current_user.tasks.find_by(id: params[:id])
    @task.is_done = false
    unless @task.save
      logger.debug("Error occured during saving task")
    end
  end

  private

  def task_create_params
    params.require(:task).permit(:title, :description, :project_id, :attachment, :tag_ids => [])
  end

  def task_update_params
    params.require(:task).permit(:title, :description, :project_id, :attachment, :is_done, :tag_ids => [])
  end
end
