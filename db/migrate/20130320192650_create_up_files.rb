class CreateUpFiles < ActiveRecord::Migration
  def change
    create_table :up_files do |t|
      t.string :Url
      t.string :mail

      t.timestamps
    end
  end
end
