class HomesController < ApplicationController
  
  def top
    @projects = Project.where(status: "recruiting").top_order
    @sample_projects = Project.where(status: "recruiting").sample(5)
    @notifications = Notification.top_order
  end

  def about
  end

  private
#凍結されたアカウントのユーザーがホームを表示させるための記述。
    def use_before_action?
      false
    end
  
end
