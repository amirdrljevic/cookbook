class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.string :title
      t.string :author
      t.integer :cook_time
      t.integer :prep_time
      t.float :ratings
      t.string :image
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
