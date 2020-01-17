module PasswordGeneration
  
  extend ActiveSupport::Concern
  include BCrypt

  # To Get password of a user
  def password
    @password ||= Password.new(password_token)
  end

  # To save password into the db
  def password=(new_password)
    @password = Password.create(new_password)
    self.password_token = @password
  end

  def valid_password?(new_password)
    password == new_password
  end

end