class TutorialsController < ApplicationController
  skip_after_action :verify_authorized, only: [:new, :show]
  skip_before_action :authenticate_user!, only: :index

  before_action :find_tutorial, only: [:show, :edit, :update, :destroy]

  def index
    @tutorials = policy_scope(Tutorial).order(created_at: :desc)
    @categories = Category.all
  end

  def show
  end

  def new
    @tutorial = Tutorial.new
    @categories = Category.all
  end

  def create
    @tutorial = Tutorial.new(tutorial_params)
    @tutorial.video_id = tutorial_params.split("=")[1]
    @tutorial.user = current_user
    authorize @tutorial
    if @tutorial.save
      redirect_to tutorial_path(@tutorial)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @tutorial.update(tutorial_params)
      redirect_to tutorial_path(@tutorial)
    else
      render :edit
    end
  end

  def destroy
    @tutorial.destroy
    redirect_to tutorials_path(@tutorial)
  end

  private

  def find_tutorial
    @tutorial = Tutorial.find(params[:id])
    authorize @tutorial
  end

  def tutorial_params
    params.require(:tutorial).permit(:title, :category_id, :description, :video_link, :image_link)
  end
end
