class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :item_id, uniqueness: { scope: :customer_id }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 10 }

  def subtotal
    item.tax_include_price * amount
  end
end
