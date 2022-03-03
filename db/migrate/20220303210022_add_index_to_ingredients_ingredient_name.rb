class AddIndexToIngredientsIngredientName < ActiveRecord::Migration[6.1]
  def change
    add_index :ingredients, :ingredient_name
  end
end
