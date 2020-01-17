class Api::V1::SessionsController < Api::V1::ApplicationController

  def create
    @user = User.find_by_email(params[:email])
    if @user.present?
      if @user.valid_password?(params[:password])
        authenticate(@user)
        @data = @user.as_json({
          only: [:name, :email],
          methods: [:authentication_token]
        })
      else
        @errors << "Invalid password"
      end
    else
      @errors << "Invalid email"
    end
    api_response
  end

end