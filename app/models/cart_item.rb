class CartItem < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  def subtotal
    item.tax_include_price * amount
  end
end
