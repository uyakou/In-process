class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  PER = 8


  def index
    @users = User.page(params[:page]).per(PER)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path alert: "不正なアクセスです。一覧画面に戻ります。"
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "プロフィールを更新しました。"
    else
      render :edit
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:username, :email, :profile, :profile_image)
  end

end