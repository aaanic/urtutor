class User < ApplicationRecord
  has_many :tutorials
  has_many :tutorials, through: :lessons
  has_many :lessons

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
