class HomesController < ApplicationController
  
  def top
    @projects = Project.all.order(created_at: :desc).first(4)
    @sample_prohects = Project.where(status: "recruiting").sample(5)
    @notifications = Notification.all.order(created_at: :desc).first(4)
  end

  def about
  end

  private
#凍結されたアカウントのユーザーがホームを表示させるための記述。
    def use_before_action?
      false
    end
  
end
