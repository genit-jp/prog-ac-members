class AddStageToLevels < ActiveRecord::Migration[6.0]
  def change
    add_column :levels, :stage, :integer
  end
end
