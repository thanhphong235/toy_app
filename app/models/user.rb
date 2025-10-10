class User < ApplicationRecord
#       has_many :microposts, dependent: :destroy
  validates :name, presence: true
  validates :email, presence: true, 
                              format: { with: /\A[a-zA-Z0-9]+@gmail\.com\z/,
                              message: "email khong dung dinh dang" },
                              uniqueness: true

end
