class OrderDetail < ApplicationRecord
  after_update :log_status_change

  belongs_to :order
  belongs_to :item

  enum making_status: { not_possible_to_start: 0, pending_production: 1, in_production: 2, production_complete: 3 }

  validates :item_id, uniqueness: { scope: :order_id }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }

  def subtotal
    price * amount
  end

  private

  def log_status_change
    if saved_change_to_making_status?
      Rails.logger.info "OrderDetail ##{id} のmaking_statusが変更されました: #{making_status_before_last_save} → #{making_status}"
    end
  end
end
