class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validates :title, :body, :country, presence: true
  validate :images_presence
  validate :images_count_within_limit

  private

  def images_presence
    errors.add(:images, "を1枚以上追加してください") unless images.attached?
  end

  def images_count_within_limit
    if images.attached? && images.count > 5
      errors.add(:images, "は5枚までしかアップロードできません")
    end
  end
end
