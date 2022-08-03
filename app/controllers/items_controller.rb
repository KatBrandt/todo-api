class ItemsController < ApplicationController
  def index
    items = Item.where(todo: params[:todo_id])
    render json: items, status: 200
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
    item = Item.create(item_params)
    render json: item, status: 200
  end

  private

  def item_params
    params.permit(:name, :done, :todo_id)
  end
end
