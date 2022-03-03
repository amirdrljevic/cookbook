class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy
  validates :category_name, presence: true, uniqueness: true
end
