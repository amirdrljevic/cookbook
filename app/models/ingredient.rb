class Ingredient < ApplicationRecord
  belongs_to :recipe
  include PgSearch::Model
  pg_search_scope :search_ingredient, 
                  against: { ingredient_name: 'A' },
                  using: { 
                    tsearch: { 
                      any_word: true,
                      sort_only: false,
                      dictionary: 'english', 
                      tsvector_column: 'searchable' 
                    } 
                  }
end
