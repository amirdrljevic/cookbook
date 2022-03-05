class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show ]

  def index
    if params[:category_id]&.present?
      @recipes = Recipe.where(:category_id => params[:category_id] ).order(:title).paginate(page: params[:page], per_page: 26)
    else 
      @recipes = Recipe.order(:title).paginate(page: params[:page], per_page: 26)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipes = Recipe.limit(7).order('id desc') #to populate the sidebar
    @ingredients = Ingredient.where(:recipe_id => @recipe.id)
  end

  def search
    if params[:search].blank?
      redirect_to recipes_path and return
    else 
      @parameter = params[:search].downcase
      @results = Recipe.joins(:ingredients).where("lower(ingredient_name) LIKE :search", search: "%#{@parameter}%" ).distinct.paginate(page: params[:page], per_page: 26)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recipe_params
      params.require(:recipe).permit(:title, :author, :prep_time, :cook_time, :ratings)
    end  
end
