module Order
  extend ActiveSupport::Concern
  include Kaminari::PageScopeMethods

  included do
    scope :new_order, -> (p) {order("created_at desc").page(p[:page]).per(10)}
    scope :top_order, -> {all.order("created_at desc").first(4)}
    scope :login_order, -> (p) {order("current_sign_in_at desc").page(p[:page]).per(10)}
  end
end