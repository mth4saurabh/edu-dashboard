class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:create]
  def index
   
    @user = current_user
    
  end
    

  def show
    @user = current_user
  end

  def new
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the AD IQ Dashboard !"
      redirect_to @user
    else
      render 'new'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end


end
