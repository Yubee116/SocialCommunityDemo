class Group < ApplicationRecord
  belongs_to :user, :foreign_key => :creator_id

  has_many :memberships, dependent: :destroy
  has_many :users, :through => :memberships

  has_many :posts, dependent: :destroy

  validates :name, presence: true

end
