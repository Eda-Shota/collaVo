class SearchesController < ApplicationController
  def search
    @projects = Project.looks(params[:word])
    @projects = @projects.page(params[:page])
      render "/projects/index.html"
  end
  
  def search_users_project
  end
end
