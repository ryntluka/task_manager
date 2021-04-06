class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def index
    @pagy, @projects = pagy(current_user.projects.order(:id), items: 12)
  end

  def show
    @project = current_user.projects.find_by(id: params[:id])
  end

  def create
    @project = Project.new(projects_params)
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

  private

  def projects_params
    params.require(:project).permit(:title, :user_id)
  end
end
