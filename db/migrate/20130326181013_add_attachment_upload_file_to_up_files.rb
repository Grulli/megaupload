class AddAttachmentUploadFileToUpFiles < ActiveRecord::Migration
  def self.up
    change_table :up_files do |t|
      t.attachment :upload_file
    end
  end

  def self.down
    drop_attached_file :up_files, :upload_file
  end
end
