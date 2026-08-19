class UsersController < ApplicationController
  allow_unauthenticated_access only: [:new, :create] 
    before_action :ensure_correct_user, only: [:edit, :update]

  def ensure_correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  def new
    @user = User.new
  end
 
  def create
    @user = User.new(user_params)
    if @user.save
      start_new_session_for @user 
      redirect_to user_path(@user), notice: "Welcome! You have signed up successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    Rails.logger.info "PROFILE ATTACHED?: #{@user.profile_image.attached?}"
    Rails.logger.info "PARAMS: #{user_params.inspect}"


    puts "PROFILE ATTACHED?: #{@user.profile_image.attached?}"
    puts "PARAMS: #{user_params.inspect}"
    
    if @user.update(user_params)
      redirect_to @user, notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def show
    @user = User.find(params[:id])
    @sidebar_user = @user
    @book_new = Book.new
    @books = @user.books
  end

  def index
    @sidebar_user = current_user
    @book_new = Book.new
    @users = User.all
  end

  private
 
  def user_params
    if action_name == "create"
      params.require(:user).permit(:name, :profile_image, :introduction, :password, :password_confirmation, :email_address)
    else
      params.require(:user).permit(:name, :profile_image, :introduction, :email_address)
    end
  end
end
