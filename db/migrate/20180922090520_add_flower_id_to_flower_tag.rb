class AddFlowerIdToFlowerTag < ActiveRecord::Migration[5.1]
  def up
    add_column :flower_tags, :flower_id, :string
  end
end
