class UsersController < ApplicationController

  def new
  end
  def index
    @users = User.all
    render :json => @users
  end
  
  def create
    # @user = User.new(user_params)
    # @user.attributes = {is_confirmed: 0}
    # if @user.save
    #   render :json => {user: @user,status: "ok"}
    # else
    #   render :json => {status:"ng"}
    # end 
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render :json => {status: "ok"}
    else
      render :json => {status: "ng"}
    end
  end

  def confirm
    @user = User.find()
  end


 private

  def user_params
    params.require(:user).permit(:email,:name,:uid,:provider_id)
  end

end



