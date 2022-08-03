class ItemsController < ApplicationController
  def index
    items = Item.where(todo: params[:todo_id])
    render json: items, status: 200
  end
end
