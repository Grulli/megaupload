class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :end_date
      t.string :file_type

      t.timestamps
    end
  end
end
