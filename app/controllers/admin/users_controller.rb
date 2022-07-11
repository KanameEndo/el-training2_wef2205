class Admin::UsersController < ApplicationController

  before_action :admin_check
  before_action :set_user, only: %i[ show edit update destroy]

  def index
    @users = User.select(:id, :name, :email, :admin).order(created_at: "desc").page(params[:page]).per(7)
  end

  def show
    @tasks = @user.tasks.all
    @tasks = @tasks.page(params[:page]).per(7)
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to tasks_path, notice: '他の人のページは見れません'
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
  @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザーの登録が完了しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
    end
      render :edit
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice:"{@user.name}を削除しました"
    else
      redirect_to admin_users_path, notice:"管理者が存在しなくなるため削除できません"
    end
  end


private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_check
  unless current_user && current_user.admin?
    redirect_to root_path, notice: "アクセス不可です"
  end
end
end