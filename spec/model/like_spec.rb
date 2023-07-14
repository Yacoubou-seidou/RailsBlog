require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:first_person) do
    User.new(
      name: 'Yacos',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer',
      posts_counter: 0
    )
  end
  before {subject.save}
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
    Like.new(
      user: first_person,
      post: first_post
    )
  end

  context '#update_likes_counter' do
    it 'should update a post\'s like counter when a like is created' do
      expect { subject.update_likes_counter }.to change(first_post, :likes_counter).from(0).to(1)
    end
  end
end
