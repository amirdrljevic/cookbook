class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy
  validates :category_name, presence: true, uniqueness: true

  def self.find_or_create(recipe_category_name)
    if recipe_category_name == ""
      recipe_category_name = "Not recognized"
    end
      # Check if that category has already been inserted into categories table, and if it is, then use that existing category_id
      category = Category.find_by category_name: recipe_category_name

      # If category is not present in categories table, then create it
      if !category
        category = Category.create(
          category_name: recipe_category_name
        )
      end
      return category  
  end
end
