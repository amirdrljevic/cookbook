class Recipe < ApplicationRecord
  belongs_to :category
  has_many :ingredients, dependent: :destroy

  def self.find_or_create(recipe_title, recipe_author, recipe_cook_time, recipe_prep_time, recipe_ratings, recipe_image, recipe_category_id, recipe_ingredients)
    recipe_record = Recipe.where(title: recipe_title, author: recipe_author).first

    if recipe_record.nil?
      recipe_record = Recipe.create(
        title:     recipe_title,
        author:    recipe_author,
        cook_time: recipe_cook_time,
        prep_time: recipe_prep_time,
        ratings:   recipe_ratings,
        image:     recipe_image,
        category_id: recipe_category_id
      )
  
      recipe_ingredients.each do |ingredient|
        Ingredient.create(
          recipe_id: recipe_record.id,
          ingredient_name: ingredient
        )
      end
    end  
  end
end
