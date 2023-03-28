class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
#kaminariによるページネーション及び、変数に代入された要素の順番の並び替えは、models/concerns/order.rb内に定義
  include Order
end
