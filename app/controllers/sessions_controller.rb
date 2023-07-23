class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user.nil?
      handle_404(fields: "email", model: "User") and return 
    end

    if @user && @user.authenticate(params[:password])
      @token = @user.login
      render "show", status: 201
    else
      raise UnauthorizedException.new("Invalid email or password")
    end
  end
end
