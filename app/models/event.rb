class Event < ActiveRecord::Base
	attr_accessible :end_date, :file_type, :name, :user_id, :guest_list
	
	belongs_to :user
	has_many :up_files
	
	validates :name,
		:length => { :minimum => 1 }
	
	validate :validate_future_end_date
	
	def validate_future_end_date
		if end_date < Time.now
			errors.add(:end_date, "The event must end in the future") if end_date < Time.now
		end
	end
end
