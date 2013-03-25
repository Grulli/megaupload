class Event < ActiveRecord::Base
	attr_accessible :end_date, :file_type, :name, :user_id
	
	belongs_to :user
	has_many :up_files
	
	validates :name,
		:length => { :minimum => 1 }
end
