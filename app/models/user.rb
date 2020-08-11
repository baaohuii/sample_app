class User < ApplicationRecord
  validates :name, presence: true, 
    length: { maximum: Settings.validations.name.max_length }

  validates :email, presence: true, 
    length: {maximum: Settings.validations.email.max_length }, 
    format: { with: Settings.validations.email.regex }, 
    uniqueness: { case_sensitive: true }

  validates :password, presence: true, 
    length: { minimum: Settings.validations.password.min_length }

  has_secure_password  

  before_save :downcase_email
  
  private  

  def downcase_email
    email.downcase! 
  end

  def User.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
    BCrypt::Password.create string, cost: cost
  end
end
