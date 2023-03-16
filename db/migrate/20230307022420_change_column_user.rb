class ChangeColumnUser < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :freeze, from: nil, to: false
  end
end
