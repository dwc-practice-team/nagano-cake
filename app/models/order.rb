class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details
  has_many :items, through: :order_details
  
  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :name, presence: true
  validates :shipping_cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :total_payment, presence: true, numericality: { greater_than_or_equal_to: 0 }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { waiting_deposit: 0, confirm_deposit: 1, in_production: 2, preparing_shipment: 3, shipped: 4 }

  def get_shipping_infomation_from(resource)
    class_name = resource.class.name
    if class_name == 'Customer'
      self.postal_code = resource.postal_code
      self.address = resource.address
      self.name = resource.full_name
    elsif class_name == 'Address'
      self.postal_code = resource.postal_code
      self.address = resource.address
      self.name = resource.name
    end
  end

  def create_order_details(customer)
    unless order_details.first
      cart_items = customer.cart_items.includes(:item)
      cart_items.each do |cart_item|
        item = cart_item.item
        OrderDetail.create!(
          order_id: id,
          item_id: item.id,
          price: item.tax_include_price,
          amount: cart_item.amount
        )
      end
      cart_items.destroy_all
    end
  end

  def order_count
    order_details.sum(:amount)
  end
end
