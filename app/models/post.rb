class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  validate :images_count_within_limit

  private

  def images_count_within_limit
    if images.attached? && images.count > 5
      errors.add(:images, "は5枚までしかアップロードできません")
    end
  end
end
