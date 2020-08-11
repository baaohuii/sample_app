class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: Settings.validations.content.max_length}
  validates :image,content_type: { in: %w[image/jpeg image/gif image/png],
                                   message: "must be a valid image format" },
                   size:{ less_than: Settings.validations.photo.max_size_Mb.megabytes,
                   	      message: "should be less than 5MB" }
end
