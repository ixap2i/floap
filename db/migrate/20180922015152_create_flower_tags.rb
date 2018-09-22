class CreateFlowerTags < ActiveRecord::Migration[5.1]
  def change
    create_table :flower_tags do |t|
      t.string :tag
      t.integer :flower_id
      t.timestamps
    end
  end
end
