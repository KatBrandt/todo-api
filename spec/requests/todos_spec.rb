require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  describe "GET /todos" do
    before { get '/todos' }

    it 'returns todos' do
      expect(json).to_not be_empty
    end
  end
end
