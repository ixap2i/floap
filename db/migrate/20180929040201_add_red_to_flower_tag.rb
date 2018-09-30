class AddRedToFlowerTag < ActiveRecord::Migration[5.1]
  def up
    add_column :flower_tags, :red, :string
    add_column :flower_tags, :blue, :string
    add_column :flower_tags, :green, :string
  end

  def change
    change_column :flower_tags, :tag, :color, :string
  end
end
