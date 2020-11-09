class CreateSpaces < ActiveRecord::Migration[6.0]
  def change
    create_table :spaces do |t|
      t.string :name
      t.integer :price
      t.string :description
      t.belongs_to :user, index: true
      t.boolean :available
    end
  end
end
