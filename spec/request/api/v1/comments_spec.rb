require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
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

  let(:ali) do
    User.new(
      name: 'Ali',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Hi there, I\'m Ali! I\'m not just your typical actress;',
      email: 'nancywheeler@gmail.com',
      password: '123456',
      password_confirmation: '123456'
    )
  end

  let(:first_post) do
    Post.create(
      author: yacos,
      title: 'Hello',
      text: 'This is my first post'
    )
  end

  let(:first_comment) do
    Comment.create(
      post: first_post,
      user: ali,
      text: 'Yacos, your innovative spirit is truly inspiring!'
    )
  end

  let(:second_comment) do
    Comment.create(
      post: first_post,
      user: yacos,
      text: "Thanks Ali for your kind words! You're the best!"
    )
  end

  before do
    yacos.skip_confirmation_notification!
    yacos.confirmed_at = Time.now
    yacos.save!
    ali.skip_confirmation_notification!
    ali.confirmed_at = Time.now
    ali.save!
    first_post
    first_comment
    second_comment
  end

  path '/api/v1/posts/{post_id}/comments' do
    parameter name: 'post_id', in: :path, type: :string, description: 'ID of a post'

    get 'List all comments on a user\'s post' do
      tags 'Comments'
      response 200, 'Successful' do
        let(:post_id) { first_post.id }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data.length).to eq first_post.comments_counter
        end
      end

      response 404, 'Not found' do
        let(:post_id) { first_post.id + 20 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to have_key 'error'
          expect(data['error']).to include "Couldn't find Post"
        end
      end
    end

    post 'Create a comment on a user\'s post' do
      tags 'Comments'
      consumes 'application/json'

      parameter name: 'X-Token', in: :header, type: :string, description: 'API token'
      parameter name: 'text', in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: [:text]
      }
      description 'Your API token is generated on sign up. It is located on your user profile page.'

      response 201, 'Comment created' do
        let(:user_id) { yacos.id }
        let(:post_id) { first_post.id }
        let(:text) { { text: 'Nice post!' } }
        let(:'X-Token') { ali.api_token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to have_key 'success'
        end
      end

      response 400, 'Comment not created' do
        let(:user_id) { yacos.id }
        let(:post_id) { first_post.id }
        let(:text) { {} }
        let(:'X-Token') { ali.api_token }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to have_key 'error'
        end
      end
    end
  end
end
