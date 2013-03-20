class AddEventIdColumnToUpFiles < ActiveRecord::Migration
  def change
    add_column :up_files, :event_id, :integer
  end
end
