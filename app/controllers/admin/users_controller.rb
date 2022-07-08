class Admin::UsersController < ApplicationController

  #ログインしてるユーザーと権限を持っているユーザーが同じかチェック
  before_action :admin_check
  before_action :set_user, only: %i[ show edit update destroy]

  def index
    @users = User.select(:id, :name, :email, :admin).order(created_at: "desc").page(params[:page]).per(7)
    #ユーザーのid、名前、メール、権限、を選んで(select)表示。登録順に表示。
  end

  def show
    @tasks = @user.tasks.all
    @tasks = @tasks.page(params[:page]).per(7)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
  @user = User.new(user_params)
  #送信されてきた値
    if @user.save
      #登録を押したとき
      redirect_to admin_users_path, notice: "ユーザーの登録が完了しました"
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      #編集を押したとき
      redirect_to admin_users_path, notice: "ユーザーを更新しました"
    end
      render :edit
  end

  def destroy_action
    if @user.destroy
      #
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
    #true/falseを返す。
    redirect_to root_path, notice: "アクセス不可です"
  end
end
end