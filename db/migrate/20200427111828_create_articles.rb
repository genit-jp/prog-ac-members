class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.float :priority
      t.boolean :is_active

      t.timestamps
    end
  end
end
