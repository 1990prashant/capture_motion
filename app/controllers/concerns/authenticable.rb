module Authenticable
  extend ActiveSupport::Concern
  include BCrypt

  def authenticate(object)
    object.last_login = Time.now
    object.login_count = object.login_count.to_i + 1
    object.save
    Authentication.create(token: Password.create([object.mobile, object.email].join), user_id: object.id)
  end

  private

    def authenticate_user
      auth = Authentication.find_by_token_and_active(request.headers['AUTHORIZATION'].to_s, true)
      if auth.try(:user).present?
        session[:user_token] = request.headers['AUTHORIZATION']
        return true
      else
        @errors << "Invalid User"
        api_response
      end
    end

    def authenticate_application
      if params[:app_id] == APP_ID && params[:app_secret] == APP_SECRET
        return true
      else
        @errors << "Invalid source"
        api_response
      end
    end

end