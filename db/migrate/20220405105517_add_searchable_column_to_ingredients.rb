class AddSearchableColumnToIngredients < ActiveRecord::Migration[7.0]
  #Add a column that would be searchable and optimised, to avoid conversion to tsvector every time a search is conducted
  def up
    execute <<-SQL
      ALTER TABLE ingredients
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(ingredient_name, '')), 'A') 
      ) STORED;
    SQL
  end

  def down 
    remove_column :ingredients, :searchable
  end
end
