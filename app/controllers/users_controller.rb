class UsersController < ApplicationController
  before_action :ensure_normal_user, only: [:update, :edit]

  def ensure_normal_user
    if current_user.email == 'guest@example.com'
      redirect_to root_path
      flash[:alert] = 'ゲストユーザーの編集・削除はできません。'
    end
  end

  def show
    @user = User.find(params[:id])
    @post = Post.new
    @posts = @user.posts.page(params[:page]).reverse_order
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:success] = "プロフィールを更新しました。"
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def user_params_update
    params.require(:user).permit(:name, :email, :profile_image)
  end
end
