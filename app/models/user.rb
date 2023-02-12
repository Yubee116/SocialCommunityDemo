class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :created_groups, :class_name => "Group", :foreign_key => :creator_id 

  has_many :memberships, dependent: :destroy
  has_many :groups, :through => :memberships

  has_many :posts

  has_many :comments
end
