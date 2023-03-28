class SearchesController < ApplicationController
  
  def search
    @word = params[:word]
    @range = params[:range]
    @projects = Project.looks(params[:word],params[:range])
    @projects = @projects.order("created_at desc").page(params[:page]).per(10)
    render "/searches/search_lists.html"  
  end

  def search_users_project
    @projects = Project.where(user_id: params[:user_id])
    @projects = @projects.order("created_at desc").page(params[:page]).per(10)
    @user = User.find(params[:user_id])
    render "/searches/search_lists.html" 
  end

end
