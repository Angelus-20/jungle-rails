class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    Rails.logger.info "Found user: #{user.inspect}"
    if user && user.authenticate(params[:password])
      # Successful login
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Login successful!'
    else
      flash.now[:alert] = 'Invalid email and password combination'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
