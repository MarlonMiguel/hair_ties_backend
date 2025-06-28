class User < ApplicationRecord
    has_secure_password
  
    enum role: { user: 'user', admin: 'admin' }
  
    validates :email, presence: true, uniqueness: true
end
