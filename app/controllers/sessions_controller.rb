class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        render json: user, status: :ok
      else
        render json: { errors: ['Invalid username or password'] }, status: :unauthorized
      end
    end
  
    def destroy
      if current_user
        session.delete(:user_id)
        head :no_content
      else
        render json: { errors: ['You must be logged in to perform this action'] }, status: :unauthorized
      end
    end
    private

def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end

  end
  