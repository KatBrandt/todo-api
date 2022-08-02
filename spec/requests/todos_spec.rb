require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get '/todos' }

    it 'returns todos' do
      expect(json).to_not be_empty
      expect(json.size).to eq 10
      expect(response.status).to eq 200
      expect(response).to have_http_status 200
      #above two test the same thing
    end
  end

  describe "GET /todos/:id" do
    before { get "/todos/#{todo_id}"}

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).to_not be_empty
        expect(json[:id]).to eq(todo_id)
        expect(response.status).to eq 200
      end
    end

    context 'when record does not exist' do
      let(:todo_id) { 100 }

      it 'returns status code 404 and error message' do
        expect(response.status).to eq 404
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end
end
