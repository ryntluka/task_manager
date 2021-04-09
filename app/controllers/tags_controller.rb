class TagsController < ApplicationController
  before_action :authenticate_user!

  def new
    @tag = Tag.new
  end

  def index
    @tags_list = current_user.tags
    if params["search"].present?
      @title = params["search"]["title"]
      @tags_list = @tags_list.search_by_title(@title)
    end
    @pagy, @tags = pagy(@tags_list.order(:id), items: 12)
  end

  def show
    @tag = current_user.tags.find_by(id: params[:id])
  end

  def create
    @tag = Tag.new(tag_params)
    @tag.user = current_user
    if @tag.save
      redirect_to tags_url, flash: {success: t(:tag_saved_successfully)}
    else
      flash.now[:danger] = t(:please_review_the_problems_below)
      render :new
    end
  end

  def destroy
    @tags = current_user.tags.find_by(id: params[:id])
    if @tags.destroy
      redirect_to tags_url, flash: {warning: t(:tag_has_been_removed)}
    end
  end

  def edit
    @tag = current_user.tags.find_by(id: params[:id])
  end

  def update
    @tag = current_user.tags.find(params[:id])
    @tag.user = current_user
    @tag.update(tag_params)
    redirect_to tag_path(@tag), flash: {success: t(:tag_saved_successfully)}
  end

  private

  def tag_params
    params.require(:tag).permit(:title)
  end
end
