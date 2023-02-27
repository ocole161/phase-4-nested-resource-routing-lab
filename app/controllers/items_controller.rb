class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end
  
  def show
    render json: Item.find(params[:id])
  end

  def create
    user = User.find(params[:user_id])
    render json: user.items.create(params.permit(:name, :description, :price)), status: :created
  end

  private
  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end
