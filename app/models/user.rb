class User < ActiveRecord::Base
  attr_accessible :mail, :password
end
