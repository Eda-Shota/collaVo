class ProjectCommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = current_user.project_comments.new(project_comment_params)
    @comment.project_id = @project.id
    @comment.save
    @project_comments = ProjectComment.where(project_id: @project.id).where(user_id: current_user.id).or(ProjectComment.where(user_id: @project.user_id))
    render "project_comments/create.js"
  end
  def destroy
    ProjectComment.find_by(id: params[:id], project_id: params[:project_id]).destroy
    @project = Project.find(params[:project_id])
    @project_comments = ProjectComment.where(project_id: @project.id).where(user_id: current_user.id).or(ProjectComment.where(user_id: @project.user_id))
    render "project_comments/destroy.js"
  end
  
  private
  def project_comment_params
    params.require(:project_comment).permit(:comment)
  end
end
