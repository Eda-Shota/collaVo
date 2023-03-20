class JoinProjectsController < ApplicationController
  
  def create
    @join_project = JoinProject.create(user_id: current_user.id, project_id: params[:project_id])
    redirect_to user_joined_project_index_path(current_user.id), notice: "企画への参加を申請しました！"
  end
  
  def update
    @join_project = JoinProject.find(params[:id])
    @join_project.update(update_params)
    redirect_to project_joined_user_index_path(@join_project.project_id)
  end
  
  def destroy
    @join_project = JoinProject.find_by(user_id: current_user.id, project_id: params[:project_id])
    @join_project.destroy
    redirect_to user_joined_project_index_path(current_user.id), notice: "企画への参加を取り消しました！"
  end
  
  private

  def update_params
    params.require(:join_project).permit(:status)
  end
  
end
