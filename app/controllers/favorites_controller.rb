class FavoritesController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
    favorite = current_user.favorites.create(project_id: @project.id)
    render "favorites/create.js"
  end

  def destroy
    @project = Project.find(params[:project_id])
    favorite = current_user.favorites.find_by(project_id: @project.id)
    favorite.destroy
    render "favorites/destroy.js"
  end
  
end
