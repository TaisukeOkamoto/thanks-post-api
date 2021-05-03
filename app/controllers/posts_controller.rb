class PostsController < ApplicationController
    before_action :authenticate_user, except: :user_posts

    #ユーザーの投稿は公開する
    def user_posts
        @user = User.find_by(uid: params[:id])
        @posts = @user.posts
        render :json => @posts
    end

    def create 
        image = nil
        if params[:image]
            image = params[:image]
        end
        user_id = current_user.id
        @post = Post.new(
            content: params[:content],
            title: params[:title],
            date: params[:date],
            person: params[:person],
            user_id: user_id,
        )
        @post.image = image

        image_url = @post.image.attachment.service.send(:object_for, @post.image.key).public_url #S3から画像URLを取得

        @post.assign_attributes(image_url: image_url)
        
        if @post.save
            render :json => {posts: current_user.posts, message: "保存に成功しました"}
        else
            render :json => {message: "保存に失敗しました"}
        end
    end

    def destroy
        @post = Post.find(params[:id])

        if @post.delete
            render :json => {message: "記事の削除に成功しました", posts: current_user.posts}
        else
            render :json => {message: "記事の削除に失敗しました"}
        end
    end

end