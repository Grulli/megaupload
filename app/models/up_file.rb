class UpFile < ActiveRecord::Base
  	attr_accessible :Url, :mail, :event_id, :upload_file
  
  	belongs_to :event
  
	def gen_token
		token = ""
		mail.chars.to_a.each do |c|
			val = c.ord #- 96
			if val < 10
				token = token + "00" + val.to_s
			else
				if val < 100
					token = token + "0" + val.to_s
				else
					token = token + val.to_s
				end
			end
		end
		token = token + event_id.to_s
		srand token.to_i
		token = token + rand(token.to_i).to_s
		return token
	end

	has_attached_file :upload_file
	
  
end
