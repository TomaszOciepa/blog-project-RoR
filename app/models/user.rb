class User < ApplicationRecord
    # Associations
    has_many :posts, dependent: :destroy
    has_many :comments
  
    # Roles
    enum :role, { viewer: 0, writer: 1, admin: 2 }
  
    # Devise modules
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable
  end
  