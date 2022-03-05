# Fetch from json
all_recipes = JSON.parse(File.read(Rails.root.join('db/recipes-english-shortened.json')))

all_recipes.each do |recipe|
  # Check if that category has already been inserted into categories table, and if it is, then use that existing category_id
  category = Category.find_or_create(recipe['category'])
 
  recipe_record = Recipe.find_or_create(recipe['title'], 
                                        recipe['author'], 
                                        recipe['cook_time'], 
                                        recipe['prep_time'],
                                        recipe['ratings'],
                                        recipe['image'],
                                        category.id,
                                        recipe['ingredients'])
end