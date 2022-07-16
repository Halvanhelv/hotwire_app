# frozen_string_literal: true

class UsersController < ApplicationController
  def new
    user = User.new

    render locals: { user: user }
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_path
    else
      render :new, locals: { user: user }
    end
  end

  def edit
    render locals: {
      user: resource_user
    }
  end

  def update
    if resource_user.update(user_params)
      # flash[:success] = t('shared.messages.updated', resource_name: User.model_name.human)
      redirect_to root_path
    else
      render locals: {
        user: resource_user
      }
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path
  end

  private

  def resource_user
    @resource_user ||= params[:id].present? ? User.find(params[:id]) : User.new(user_params)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
