class Api::V1::ProductsController < Api::V1::ApplicationController
  before_action :authenticate_user
  include ::Autherization
  before_action :find_product, only: [:show, :update, :destroy]

  def index
    if params[:category_id].present?
      products = Product.where(category_id: params[:category_id])
    else
      products = Product.all
    end
    @data = products.as_json({
      only: [:id, :name, :category_id, :description, :price, :make]
    })
    api_response
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      @data = @product.as_json({
        only: [:id, :name, :category_id, :description, :price, :make]
      })
    else
      @errors = @product.errors.full_messages
    end
    api_response
  end

  def show
    @data = @product.as_json({
      only: [:id, :name, :category_id, :description, :price, :make]
    })
    api_response
  end

  def update
    if @product.update_attributes(product_params)
      @data = @product.as_json({
        only: [:id, :name, :category_id, :description, :price, :make]
      })
    else
      @errors = @product.errors.full_messages
    end
    api_response
  end

  def destroy
    unless @product.destroy
      @errors = @product.errors.full_messages
    end
    api_response
  end

  private

    def product_params
      params.require(:product).permit(:name, :category_id, :description, :price, :make)
    end

    def find_product
      @product = Product.find_by_id(params[:id])
      if @product.blank?
        @errors = ["No product found with this id"]
        api_response
      end
    end

end