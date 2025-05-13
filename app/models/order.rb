class Order < ApplicationRecord
  after_update :log_status_change

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

  def total_price
    order_details.sum(&:subtotal)
  end

  def update_status_based_on_details
    if order_details.where(making_status: "in_production").exists?
      update(status: "in_production")
    elsif order_details.where.not(making_status: "production_complete").empty?
      update(status: "preparing_shipment")
    end
  end

  private

  def log_status_change
    if saved_change_to_status?
      Rails.logger.info "Order ##{id} のステータスが変更されました: #{status_before_last_save} → #{status}"
    end
  end
end
