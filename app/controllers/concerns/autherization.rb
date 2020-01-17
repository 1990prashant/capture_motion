module Autherization
  extend ActiveSupport::Concern

  included do
    before_action :check_autherization
  end

  private

    def check_autherization
      if !current_user.is_admin?
        @errors << "Only admin can access this section"
        api_response
      end
    end

end