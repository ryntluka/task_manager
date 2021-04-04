class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find_by(id: params[:id])
  end

  def create
    @project = Project.new(projects_params)
    @project.position = 1
    if @project.save
      redirect_to projects_url
    else
      render json: @error = @projects.errors
    end
  end

  def destroy
    @projects = current_user.projects.find_by(id: params[:id])
    if @projects.destroy
      redirect_to projects_url
    end
  end

  def do
    @projects = current_user.projects.find_by(id: params[:id])
    @projects.is_done = true
    @projects.save
    redirect_to projects_url
  end

  def undo
    @projects = current_user.projects.find_by(id: params[:id])
    @projects.is_done = false
    @projects.save
    redirect_to projects_url
  end

  private

  def projects_params
    params.require(:project).permit(:title, :user_id)
  end
end
