class CreatePermittedUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :permitted_users do |t|
      t.string :email

      t.timestamps
    end
  end
end
