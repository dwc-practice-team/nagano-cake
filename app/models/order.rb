class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }

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
end
