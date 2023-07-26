require 'rails_helper'

RSpec.describe '/users', type: :request do
  let(:person) do
    User.new(
      name: 'Yacos',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer',
      posts_counter: 0,
      email: 'yacos@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  before do
    person.save!
  end

  context 'GET /index' do
    it 'renders a list of all users' do
      get '/users'
      expect(response.status).to eq 200
      expect(response).to render_template 'users/index'
      expect(response.body).to include person.name
    end
  end

  context 'GET /show' do
    it 'renders a user' do
      get "/users/#{person.id}"
      expect(response.status).to eq 200
      expect(response).to render_template 'users/show'

      expect(response.body).to include person.name
      expect(response.body).to include person.bio
      expect(response.body).to include person.photo
    end
  end
end
