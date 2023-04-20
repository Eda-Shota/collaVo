class ProjectCommentsController < ApplicationController

  def index
    @project_comments = ProjectComment.all.new_order(params)
    @pagenation = @project_comments
  end
  
  def create
    @comment = current_user.project_comments.create(project_comment_params)
    @comment.score = Language.get_data(project_comment_params[:comment]) #google natural language APIを使用
    @comment.save
    @project = Project.find(@comment.project_id)
    get_comments_list
    render "project_comments/create.js"
  end
  
  def destroy
    @project_comment = ProjectComment.find(params[:id])
    @project = Project.find(@project_comment.project_id)
    @project_comment.destroy
    get_comments_list
    render "project_comments/destroy.js"
  end
  
  private
  
  def project_comment_params
    params.require(:project_comment).permit(:comment, :project_id, :user_id).merge(user_id: current_user.id)
  end

  def get_comments_list
    if admin_signed_in?
      @project_comments = ProjectComment.all.new_order(params)
    else
      @project_comments = ProjectComment.where(user_id: current_user.id).or(ProjectComment.where(user_id: @project.user_id)).where(project_id: @project.id)
    end
  end

end