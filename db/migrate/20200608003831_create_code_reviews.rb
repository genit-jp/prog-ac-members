class CreateCodeReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :code_reviews do |t|
      t.integer :user_id
      t.integer :answer_id
      t.boolean :lgtm

      t.timestamps
    end
  end
end
