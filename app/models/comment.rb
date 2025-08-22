class Comment < ApplicationRecord
  belongs_to :post
  
  validates :author,  presence: true, length: { maximum: 60 }
  validates :content, presence: true
end
