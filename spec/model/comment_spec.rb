require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:first_person) do
    User.create(
      name: 'Yacos',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer',
      posts_counter: 0
    )
  end

  before { first_person.save }

  let(:first_post) do
    Post.new(
      author: first_person,
      title: 'Hello',
      text: 'This is my first post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  subject do
    Comment.create(
      user: first_person,
      post: first_post,
      text: 'Good one!'
    )
  end

  context '#update_comment_counter' do
    it 'should update a post\'s comment counter when a comment is created' do
      expect { subject }.to change(first_post, :comments_counter).from(0).to(1)
    end
  end
end
