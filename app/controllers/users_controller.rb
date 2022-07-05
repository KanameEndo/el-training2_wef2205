class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new(user_params)
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      format.html { redirect_to user_url(@user), notice: "User was successfully created." }
    else
      format.html { render :new, status: :unprocessable_entity }
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_digest, :password_confirmation, :admin)
  end
end
