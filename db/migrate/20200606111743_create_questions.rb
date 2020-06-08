class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.integer :stage
      t.integer :level
      t.integer :index
      t.string :title
      t.boolean :availabled

      t.timestamps
    end
  end
end
