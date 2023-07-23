class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def create
    # change pwd confirmation
    if params[:password] != params[:password_confirmation]
      handle_422(fields: "password_confirmation") and return
    end

    @user = User.new(create_params)

    if @user.save
      render "show", status: 201
    else
      @record = @user
      render "common/record_error", status: 422
    end
  end

  def show
    @user = @current_user
    render "show"
  end

  private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
