class SessionsController < ApplicationController
  def new
    @errors = []
  end

  def create
    @user = User.find_by(email: params[:login][:email])
    if @user && @user.authenticate(params[:login][:password])
      flash[:success] = 'Login successful.'
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:danger] = 'Login unsuccessful.'
      @errors = populate_errors
      render :new
    end
  end

  def destroy
    session.clear
    flash[:success] = 'Logout successful.'
    redirect_to root_path
  end

  private

  def populate_errors
    errors = []
    errors << "Email can't be blank" if params[:login][:email].empty?
    errors << "Password can't be blank" if params[:login][:password].empty?
    errors << 'Credentials are invalid' if errors.empty?
    errors
  end
end
