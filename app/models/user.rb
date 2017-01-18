class User < ActiveRecord::Base
  has_secure_password

  def fullname
    "#{firstname} #{lastname}".titleize
  end
end
