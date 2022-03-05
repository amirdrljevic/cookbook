# Alter the sequence, let the id in table categories start from 2
connection = ActiveRecord::Base.connection()
connection.execute("ALTER SEQUENCE categories_id_seq START with 2 RESTART;")

# There are 65 recipes in JSON file without specified category, 
# I will create "Not categorized" category and assign it to any 'uncategorized' recipe
Category.create(
  id: 1,
  category_name: "Not categorized"
)

# Fetch from json
all_recipes = JSON.parse(File.read(Rails.root.join('db/recipes-english.json')))

category = Category.new

all_recipes.each do |recipe|
  
  # First check, if category is empty for a given recipe, then assign it id = 1
  if recipe['category'] == ""
    category.id = 1
  else 
    # Check if that category has already been inserted into categories table, and if it is, then use that existing category_id
    category = Category.find_by category_name: recipe['category']

    # If category is not present in categories table, then create it
    if !category
      category = Category.create(
        category_name: recipe['category']
      )
    end
  end

  x = Recipe.create(
   title:     recipe['title'],
   author:    recipe['author'],
   cook_time: recipe['cook_time'],
   prep_time: recipe['prep_time'],
   ratings:   recipe['ratings'],
   image:     recipe['image'],
   category_id: category.id
  )

  recipe['ingredients'].each do |ingredient|
    Ingredient.create(
      recipe_id: x.id,
      ingredient_name: ingredient
    )
  end
end