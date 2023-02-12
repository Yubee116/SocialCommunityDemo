class Group < ApplicationRecord
  belongs_to :user, :foreign_key => :creator_id

  has_many :memberships, dependent: :destroy
  has_many :users, :through => :memberships

  has_many :posts, dependent: :destroy

  validates :name, presence: true

  before_save :set_last_activity

    def set_last_activity
        self.last_activity = Time.now
    end
end
