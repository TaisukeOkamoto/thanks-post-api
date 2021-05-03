class UsersController < ApplicationController
  before_action :authenticate_user, except: :show
  
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

  #
  def show 
    user = User.find_by(uid: params[:id])
    if user
      render :json => {
        user: {
          name: user.name,
          profile_text: user.profile_text,
          image_url: user.image_url,
          list_url: user.list_url
        }, 
        message: 'ユーザーの取得に成功しました'
      }
    else
      render :json => {message: 'ユーザーの取得に失敗しました'}
    end
  end

  def update
    # if sub = params[:sub]
    #   user = User.find_by(sub: sub)
    # else
      user = User.find_by(uid: params[:id])
    # end
    if avatar = params[:avatar]
      user.avatar = avatar
      image_url = user.avatar.attachment.service.send(:object_for, user.avatar.key).public_url #S3から画像URLを取得
      user.assign_attributes(image_url: image_url)
    end
    if user.update(user_params)
      render :json => {user: user, message: "ユーザー情報の更新に成功しました"}
    else
      render :json => {message: "ユーザー情報の更新に失敗しました"}
    end
  end

 private

  def user_params
    params.permit(:id,:email,:name,:sub,:provider_id,:name,:profile_text,:list_url)
  end

end



