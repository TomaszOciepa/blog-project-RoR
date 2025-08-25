class Admin::UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
  
    def index
      @users = User.all.order(:email)
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_users_path, notice: "User updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @user = User.find(params[:id])
      if @user == current_user
        redirect_to admin_users_path, alert: "You cannot delete yourself."
      else
        @user.destroy
        redirect_to admin_users_path, notice: "User deleted."
      end
    end
  
    private
  
    def authorize_admin!
      redirect_to root_path, alert: "Not authorized." unless current_user.admin?
    end
  
    def user_params
      params.require(:user).permit(:email, :role)
    end
  end
  