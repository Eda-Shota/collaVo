class SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]
    @projects = Project.looks(params[:word],params[:range])
    @projects = @projects.new_order(params)
    @pagenation = @projects
    render "/searches/search_lists.html"
  end

  def search_users_project
    @projects = Project.where(user_id: params[:user_id])
    @projects = @projects.new_order(params)
    @user = User.find(params[:user_id])
    @pagenation = @projects
    render "/searches/search_lists.html" 
  end

end
