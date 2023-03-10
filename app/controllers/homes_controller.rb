class HomesController < ApplicationController
  def top
    @projects = Project.all.order(created_at: :desc).first(4)
  end

  def about
  end
end
