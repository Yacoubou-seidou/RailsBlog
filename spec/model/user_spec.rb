require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: 'Yacos',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer'
    )
  end
  before { subject.save }

  context '#name' do
    it 'name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

  context '#posts_counter' do
    it 'post counter should not be nil' do
      subject.posts_counter = nil
      expect(subject).to_not be_valid
    end

    it 'post counter should be greater than or equal to 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'post counter should accept only integer values' do
      subject.posts_counter = 2.45
      expect(subject).to_not be_valid
    end

    it 'post counter should accept zero' do
      subject.posts_counter = 0
      expect(subject).to be_valid
    end

    it 'post counter should accept positive values' do
      subject.posts_counter = 1
      expect(subject).to be_valid
    end
  end

  context '#latest_posts' do
    it 'should return the latest posts of the user' do
      post1 = Post.new(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
      post2 = Post.new(author: subject, title: 'Hello', text: 'This is my second post', comments_counter: 0, likes_counter: 0)
      post3 = Post.new(author: subject, title: 'Hello', text: 'This is my third post', comments_counter: 0, likes_counter: 0)
      post4 = Post.new(author: subject, title: 'Hello', text: 'This is my fourth post', comments_counter: 0, likes_counter: 0)
      post5 = Post.new(author: subject, title: 'Hello', text: 'This is my fifth post', comments_counter: 0, likes_counter: 0)
      subject.posts = [post1, post2, post3, post4, post5]

      expect(subject.latest_posts).to eq [post5, post4, post3]
    end
  end
end
