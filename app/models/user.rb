class User < ActiveRecord::Base
	attr_accessible :mail, :password
	validates :mail,
		:uniqueness => true,
		:format => { :with => /^[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}$/i }
	validates :password,
		:length => { :minimum => 6 }
end
