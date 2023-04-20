class ApplicationController < ActionController::Base
  before_action :user_check, if: :use_before_action? 

  private 
  def user_check
    if current_user.freeze == true
      redirect_to root_path , notice: 'アカウントが凍結されています。確認、復帰以来はお問い合わせフォームへ。'
    end
  end
#お問い合わせのコントローラーで、上記のアクションが実行されるようになっています。
  def use_before_action?
    true
  end

end
