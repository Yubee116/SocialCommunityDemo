class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, :content, presence: true

  has_many :comments, dependent: :destroy

  before_save :set_last_activity

    def set_last_activity
        self.last_activity = Time.now
    end
end
