class Api::V1::ApplicationController < ActionController::Base

  include ::Authenticable

  protect_from_forgery with: :null_session
  before_action :init_vars

  def current_user
    unless session[:user_token].nil?
      @current_user ||= Authentication.find_by_token(session[:user_token]).try(:user)
    end
  end

  def init_vars
    @data = []
    @errors = []
  end

  def api_response
    render json: {
      success: @errors.blank?,
      data: @data,
      errors: @errors
    }
  end

end