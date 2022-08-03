require 'rails_helper'

RSpec.describe "Items", type: :request do
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:id) { items.first.id }

  describe "GET /todos/:todo_id/items" do
    before { get "/todos/#{todo_id}/items" }

    context 'when todo exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all todo items' do
        expect(json.size).to eq 20
      end
    end
  end

  describe "GET /todos/:todo_id/items/:item_id" do
    before { get "/todos/#{todo_id}/items/#{id}" }

    context 'when todo item exists' do
      it 'returns tatus code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the item' do
        expect(json[:id]).to eq id
      end
    end
  end

  describe "POST /todos/:todo_id/items" do
    it 'creates new item with valid attributes' do
      attributes = { name: "Get Cake", done: false }

      post "/todos/#{todo_id}/items", params: attributes

      expect(response).to have_http_status 200
      expect(json[:todo_id]).to eq todo_id
      expect(json[:name]).to eq "Get Cake"
    end
  end
end
