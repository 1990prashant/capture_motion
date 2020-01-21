class Api::V1::UsersController < Api::V1::ApplicationController

  before_action :authenticate_application, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save
      authenticate(@user)
      @data = @user.as_json({
        only: [:name, :email],
        methods: [:authentication_token]
      })
    else
      @errors = @user.errors.full_messages
    end
    api_response
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :mobile, :password)
    end

end