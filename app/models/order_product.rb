class OrderProduct < ApplicationRecord

  belongs_to :order
  belongs_to :product
  delegate :price, to: :product
  alias_method :unit_price, :price

  after_save :update_order_attributes

  def total_price
    self.quantity.to_i * price.to_f
  end

  private

    def update_order_attributes
      order.item_count = order.item_count.to_i + self.quantity
      order.item_total = order.item_total.to_f + (self.quantity * self.product.price.to_f)
      order.save
    end
  
end
