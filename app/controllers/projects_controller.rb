class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def index
    projects_list = current_user.projects
    if params["search"].present?
      @title = params["search"]["title"]
      logger.debug("HERE")
      logger.debug(@title)
      logger.debug("HERE")
      projects_list = projects_list.search_by_title(@title)
    end
    @pagy, @projects = pagy(projects_list.includes([:tasks]).order(:id), items: 12)
  end

  def show
    @project = current_user.projects.find_by(id: params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.position = 1
    @project.user = current_user
    if @project.save
      redirect_to projects_url, flash: {success: t(:project_saved_successfully)}
    else
      flash.now[:danger] = t(:please_review_the_problems_below)
      render :new
    end
  end

  def destroy
    @project = current_user.projects.find_by(id: params[:id])
    if @project.destroy
      redirect_to projects_url, flash: {warning: t(:the_project_has_been_removed)}
    end
  end

  def edit
    @project = current_user.projects.find_by(id: params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
    @project.user = current_user
    @project.update(project_params)
    redirect_to project_path(@project), flash: {success: t('the_project_was_saved_successfully')}
  end

  private

  def project_params
    params.require(:project).permit(:title)
  end
end
