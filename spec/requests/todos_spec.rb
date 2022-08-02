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

  describe 'POST /todods' do
    let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(response).to have_http_status 201
        expect(json[:title]).to eq 'Learn Elm'
        expect(json[:created_by]).to eq '1'
      end
    end
  end

  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response).to have_http_status 204
        expect(json[:title]).to eq 'Shopping'
        expect(json[:id]).to eq todo_id
      end
    end
  end
end
