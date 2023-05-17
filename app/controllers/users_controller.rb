class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]
  before_action :set_user, only: [:show,:destroy]

  def index
    @user=User.all
    render json: @user ,status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.new(user_prm)
    if @user.save
      render json: @user ,status: :created
    else 
      render json: {errors: @user.errors.full_messages}
    end
  end

  def update
    byebug
    if @user.update(user_prm)
      render json: @user,status: :update
    # else
    #   render json: status: :unprocessable_entity
    end
  end

  def destroy
    byebug
    @user.destroy 
  end

  def check
    render plain:"check method ahs been hit"
  end

  private

    def user_prm
      params.permit(:username, :email, :password)
    end

    def set_user
      @user = User.find_by_username(params[:_username])
    end
end