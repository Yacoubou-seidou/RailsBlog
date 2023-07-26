require 'rails_helper'

RSpec.describe '/users/posts', type: :request do
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

  let(:first_post) do
    Post.create(
      author: person,
      title: 'A Post',
      text: 'Writing my post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  before do
    person.save!
    first_post
  end

  context 'GET /index' do
    it 'renders a list of a user\'s posts' do
      get "/users/#{person.id}/posts"
      expect(response.status).to eq 200
      expect(response).to render_template 'posts/index'
      expect(response.body).to include first_post.text
    end
  end

  context 'GET /show' do
    it 'renders a particular post for a given user' do
      get "/users/#{person.id}/posts/#{first_post.id}"
      expect(response.status).to eq 200
      expect(response).to render_template 'posts/show'
      expect(response.body).to include first_post.title
      expect(response.body).to include first_post.text
    end
  end
end
