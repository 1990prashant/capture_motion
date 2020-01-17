class User < ApplicationRecord

  include PasswordGeneration

  has_many :orders
  has_one :authentication
  delegate :token, to: :authentication, prefix: true
  validate :valid_email

  def is_admin?
    self.role.to_s == "admin"
  end

  def running_order
    orders.where(status: "open").first
  end

  private

    def valid_email
      unless (self.email =~ VALID_EMAIL_REGEX) == 0
        self.errors.add(:base, "Invalid email, please provide a valid email address")
      end
    end

end
