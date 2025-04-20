class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :cart_items

  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  validates :genre_id, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [600, 600]).processed
  end

  def tax_include_price
    (price * 1.1).floor
  end
end
