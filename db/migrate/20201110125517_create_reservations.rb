class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.date :date
      t.belongs_to :user, index: true
      t.belongs_to :space, index: true
      t.boolean :confirmed
    end
  end
end
