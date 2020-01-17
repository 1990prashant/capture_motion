class Order < ApplicationRecord

  has_many :order_products
  has_many :products, through: :order_products
  before_create :populate_number

  def generate_number(current_number = "CMS-#{self.user_id}#{Time.now.strftime("%d%m%Y%H%M%S")}#{SecureRandom.hex(4)}")
    return current_number if Order.find_by_number(current_number).blank?
    generate_number
  end

  def populate(line_item, errors = [])
    order_product = order_products.find_or_initialize_by(product_id: line_item[:product_id])
    order_product.quantity = order_product.quantity.to_i + line_item[:quantity]
    errors << order_product.errors.full_messages.join(", ") unless order_product.save
  end

  def line_items
    order_products.as_json({
      only: [:id],
      methods: [:quantity, :unit_price, :total_price]
    })
  end

  private

    def populate_number
      self.number = generate_number
    end
  
end
