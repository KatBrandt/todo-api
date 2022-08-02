class TodosController < ApplicationController
  def index
    todos = Todo.all
    render json: todos
  end

  def show
    todo = Todo.find(params[:id])
    render json: todo

  rescue ActiveRecord::RecordNotFound => e
    render json: {
      error: e.to_s
    }, status: :not_found
  end

  def create
    todo = Todo.create(todo_params)
    render json: todo, status: 201
  end

  def update
    todo = Todo.find(params[:id])
    if todo
      todo.update(todo_params)
      render json: todo, status: 204
    else
      render json: {
        error: "Record not Found",
        status: 404
      }
    end
  end

  private

  def todo_params
    params.permit(:title, :created_by)
  end
end
