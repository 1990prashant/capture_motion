class Api::V1::CartsController < Api::V1::ApplicationController
  before_action :authenticate_user

  def index
    @data = current_user.running_order.as_json({
      only: [:number, :item_count, :item_total],
      methods: [:line_items]
    }) if current_user.running_order.present?
    api_response
  end

  def create
    ActiveRecord::Base.transaction do
      if current_user.running_order.blank?
        @order = current_user.orders.create(status: "open")
      else
        @order = current_user.running_order
      end
      @order.populate(params, @errors)
    end
    if @errors.blank?
      @data = @order.as_json({
        only: [:number, :item_count, :item_total],
        methods: [:line_items]
      })
    end
    api_response
  end

end