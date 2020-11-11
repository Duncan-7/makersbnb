class RemoveAvailableColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :spaces, :available, :boolean
  end
end
