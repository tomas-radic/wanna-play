class UsersController < ApplicationController

	before_action :authenticate_user!

  def password_change

  end

  def password_change_confirm
		if current_user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      bypass_sign_in(current_user)
      redirect_to root_path
    else
      render :password_change
    end
  end


  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
