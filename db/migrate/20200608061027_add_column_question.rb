class AddColumnQuestion < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :link, :string
  end
end
