module Users
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def edit
      @user = current_user
    end

    def update
      @user = current_user
      if update_resource(@user, user_params)
        redirect_to posts_path(scope: "my"), notice: "プロフィールを更新しました"
      else
        Rails.logger.debug @user.errors.full_messages
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :introduction, :avatar)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end
  end
end