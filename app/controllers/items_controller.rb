class ItemsController < ApplicationController
  def index
    items = Item.where(todo: params[:todo_id])
    render json: items, status: 200
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end
end
