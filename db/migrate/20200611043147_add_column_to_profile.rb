class AddColumnToProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :github_id, :string
  end
end
