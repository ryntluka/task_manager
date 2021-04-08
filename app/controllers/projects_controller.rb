class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def index
    @pagy, @projects = pagy(current_user.projects.includes([:tasks]).order(:id), items: 12)
  end

  def show
    @project = current_user.projects.find_by(id: params[:id])
  end

  def create
    @project = Project.new(project_params)
    @project.position = 1
    if @project.valid?
      @project.save
      redirect_to projects_url, flash: {success: "Project saved successfully"}
    else
      render :new
    end
  end

  def destroy
    @project = current_user.projects.find_by(id: params[:id])
    if @project.destroy
      redirect_to projects_url
    end
  end

  def edit
    @project = current_user.projects.find_by(id: params[:id])
  end

  def update
    @project = current_user.projects.find(params[:id])
    @project.update(project_params)
    redirect_to project_path(@project), flash: {success: I18n.t('the_project_was_saved_successfully')}
  end

  private

  def project_params
    params.require(:project).permit(:title, :user_id)
  end
end
