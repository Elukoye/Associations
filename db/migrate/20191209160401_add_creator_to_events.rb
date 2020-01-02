class AddCreatorToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :creator_id, :integer
    add_index :events, :creator_id
  end
end
