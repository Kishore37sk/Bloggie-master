class UsersController < ApplicationController
  before_action :authenticate_user!,except: [:show]
  
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.js 
      else
        format.js
      end
    end
  end

private

def user_params
  params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
end

end
