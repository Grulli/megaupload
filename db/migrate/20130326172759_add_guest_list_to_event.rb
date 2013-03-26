class AddGuestListToEvent < ActiveRecord::Migration
  def change
    add_column :events, :guest_list, :string
  end
end
