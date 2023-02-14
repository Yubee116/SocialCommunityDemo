class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, :content, presence: true

  has_many :comments, dependent: :destroy
end
