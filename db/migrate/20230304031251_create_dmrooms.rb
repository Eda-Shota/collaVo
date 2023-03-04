class CreateDmrooms < ActiveRecord::Migration[6.1]
  def change
    create_table :dmrooms do |t|

      t.timestamps
    end
  end
end
