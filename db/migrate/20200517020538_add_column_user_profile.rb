class AddColumnUserProfile < ActiveRecord::Migration[6.0]
  def change
    add_column :profiles, :slack_user_id, :string
  end
end
