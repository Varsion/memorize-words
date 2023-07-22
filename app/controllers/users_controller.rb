class UsersController < ApplicationController
  def create
    # change pwd confirmation
    if params[:password] != params[:password_confirmation]
      handle_422(fields: "password_confirmation") and return
    end

    @user = User.new(create_params)

    if @user.save
      render :show, status: 201
    else
      @record = @user
      render "common/record_error", status: 422
    end
  end

  def show
  end

  def update
  end

  def destroy
  end

private

  def create_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

  def update_params
  end
end
