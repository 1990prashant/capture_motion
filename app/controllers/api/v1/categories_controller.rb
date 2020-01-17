class Api::V1::CategoriesController < Api::V1::ApplicationController
  before_action :authenticate_user
  include ::Autherization
  before_action :find_category, only: [:show, :update, :destroy]

  def index
    @data = Category.all.as_json({
      only: [:id, :name, :category_type, :model]
    })
    api_response
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      @data = @category.as_json({
        only: [:id, :name, :category_type, :model]
      })
    else
      @errors = @category.errors.full_messages
    end
    api_response
  end

  def show
    @data = @category.as_json({
      only: [:id, :name, :category_type, :model]
    })
    api_response
  end

  def update
    if @category.update_attributes(category_params)
      @data = @category.as_json({
        only: [:id, :name, :category_type, :model]
      })
    else
      @errors = @category.errors.full_messages
    end
    api_response
  end

  def destroy
    unless @category.destroy
      @errors = @category.errors.full_messages
    end
    api_response
  end

  private

    def category_params
      params.require(:category).permit(:name, :category_type, :model)
    end

    def find_category
      @category = Category.find_by_id(params[:id])
      if @category.blank?
        @errors = ["No category found with this id"]
        api_response
      end
    end
end