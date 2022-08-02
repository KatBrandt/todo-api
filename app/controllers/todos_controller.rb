class TodosController < ApplicationController
  def index
    render json: {cat: "Bella"}, status: :ok
  end
end
