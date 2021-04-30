class SessionsController < ApplicationController
    before_action :authenticate_user

    def login
        user_id = current_user.uid
        render :json => {user_id: user_id}
    end
end
