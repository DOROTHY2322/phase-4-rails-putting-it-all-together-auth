class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
          session[:user_id] = user.id
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end
  
    def me
      if current_user
        render json: current_user
      else
        head :unauthorized
      end
    end
  
    private
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
      end

      def user_params
        params.permit(:email, :username, :password, :password_confirmation, :image_url)
      end
      
      
      
  end
  