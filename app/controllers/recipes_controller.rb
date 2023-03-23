class RecipesController < ApplicationController
    before_action :authenticate_user!, only: [:create]
  
    def index
        recipes = Recipe.includes(:user).all
      
        if current_user
          render json: recipes.as_json(include: {
            user: { only: [:username, :image_url, :bio] }
          })
        else
          render json: { errors: ["You must be logged in to view recipes."] },
                 status: :unauthorized
        end
      end
      
      def create
        if current_user.nil?
          render json: { errors: ["You must be logged in to create a recipe."] }, status: :unauthorized
          return
        end
      
        recipe = current_user.recipes.build(recipe_params)
      
        if recipe.save
          render json: recipe.as_json(include: { user: { only: [:username, :image_url, :bio] } }), status: :created
        else
          render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      
      
  
    private
  
    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

  def authenticate_user!
    unless current_user
      render json: { error: "You must be logged in to perform this action." }, status: :unauthorized
    end

  end
  def recipe_params
    params.permit(:title,:instructions, :minutes_to_complete)
  end
  
  end
  