class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :joined_index, :create, :edit, :update, :destroy]
  
  def new
    @project = Project.new
  end
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if params[:post]
      if @project.update(Invitation_status: 1)
        @join = Join_project.create(user_id: current_user.id,project_id: @project.id, status: "permission" )
        redirect_to project_path(@project.id), notice: "企画を投稿しました！"
      else
        render :new, alert: "保存できませんでした"
      end
    else
      if @project.save
        @join = Join_project.create(user_id: current_user.id,project_id: @project.id, status: "permission" )
        redirect_to project_path(@project.id), notice: "下書き保存しました！"
      else
        render :new, alert: "保存できませんでした"
      end
    end
  end
  def index
    @projects = Project.where.not(Invitation_status: "draft")
  end
  def joined_index
  end
  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end
  def update
  end
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
     redirect_to root_path 
   # redirect_to user_search_users_project_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :Invitation_status, :introduction, :category, :start_time, :requirement, :capacity, :deadline, :start_time_detail)
  end
  
end