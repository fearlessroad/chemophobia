class Admin < ActiveRecord::Base
  has_secure_password
  validates :username, :email, presence:true
end
