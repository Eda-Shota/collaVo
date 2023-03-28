class ProjectsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :joined_index, :create, :edit, :update, :destroy]
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  
  def new
    @project = Project.new
  end
  
  def create
    @project = Project.new(project_params)
    @project.user_id = current_user.id
    if params[:post]
      if @project.update(status: "recruiting")
        join_project_save
        redirect_to project_path(@project.id), notice: "企画を投稿しました！"
      else
        render "new", alert: "保存できませんでした"
      end
    else
      if @project.save
        join_project_save
        redirect_to project_path(@project.id), notice: "下書き保存しました！"
      else
        render "new", alert: "保存できませんでした"
      end
    end
  end
  
  def index
    @projects = Project.where.not(status: "draft")
    @projects = @projects.new_order(params)
    @pagenation = @projects
  end

  def favorite_index
    @favorites = Favorite.order("created_at desc").where(user_id: current_user.id).pluck(:project_id)
    @projects = Project.find(@favorites)
    pagenation_array
    render "index"
  end

  def joined_user_index
    @project = Project.find(params[:project_id]) 
    @join_users = JoinProject.where(project_id: params[:project_id]).new_order(params)
    @pagenation = @join_users
  end
  
  def joined_project_index
    @join_projects = JoinProject.order("created_at desc").where(user_id: current_user.id).pluck(:project_id)
    @projects = Project.find(@join_projects)
    pagenation_array
    render "index"
  end
  
  def show
    get_comments_list
  end

  def edit
  end
  
  def update
    if @project.update(project_params)
      redirect_to project_path(@project), notice: "企画内容を変更しました"
    else
      flash[:alert] = "変更できませんでした"
    end
  end

  def destroy
    @project.destroy
    redirect_to root_path 
  end

  private

  def project_params
    params.require(:project).permit(:title, :status, :introduction, :category, :start_time, :requirement, :capacity, :deadline, :start_time_detail, :project_image)
  end

  def set_project
    @project = Project.find(params[:id]) 
  end

  def get_comments_list
    if admin_signed_in?
      @project_comments = ProjectComment.all 
    elsif user_signed_in?
      @project_comments = ProjectComment.where(user_id: current_user.id).or(ProjectComment.where(user_id: @project.user_id)).where(project_id: @project.id)
    end
  end

  def join_project_save
    @join = JoinProject.create(user_id: current_user.id,project_id: @project.id, status: "permission" )
  end
#ページメソッドを配列に適用させるための記述
  def pagenation_array
    projects_array = @projects.map(&:id)
    @pagenation = Kaminari.paginate_array(projects_array).page(params[:page]).per(10)
    
  end
  
end