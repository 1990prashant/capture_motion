class Authentication < ApplicationRecord

  default_scope -> { where(active: true) }
  belongs_to :user
  before_create :invalidate_all

  private

    def invalidate_all
      Authentication.where(user_id: self.user_id).update_all(active: false)
    end
end
