require 'swagger_helper'

RSpec.describe 'api/v1/posts', type: :request do
  let(:yacos) do
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
      author: yacos,
      title: 'First post',
      text: 'This is my first post'
    )
  end

  let(:second_post) do
    Post.create(
      author: yacos,
      title: 'Second post',
      text: 'This is my second post'
    )
  end

  let(:third_post) do
    Post.create(
      author: yacos,
      title: 'Third post',
      text: 'This is my third post'
    )
  end

  before do
    yacos.skip_confirmation_notification!
    yacos.confirmed_at = Time.now
    yacos.save!
    first_post
    second_post
    third_post
  end

  path '/api/v1/users/{user_id}/posts' do
    get 'List all posts for user with user_id' do
      tags 'Posts'
      parameter name: 'user_id', in: :path, type: :string, description: 'user_id'

      response 200, 'Successful' do
        let(:user_id) { yacos.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq yacos.posts_counter
          expect(data[0]['title']).to eq first_post.title
          expect(data[1]['title']).to eq second_post.title
          expect(data[2]['title']).to eq third_post.title
        end
      end

      response 400, 'User not found' do
        let(:user_id) { yacos.id + 2000 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to have_key 'error'
          expect(data['error']).to eq 'User not found'
        end
      end
    end
  end
end
