require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
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

  context '#posts_counter' do
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
      Post.create(author: subject, title: 'Hello', text: 'This is my first post', comments_counter: 0, likes_counter: 0)
      Post.create(author: subject, title: 'Hello', text: 'This is my second post', comments_counter: 0,
                  likes_counter: 0)
      Post.create(author: subject, title: 'Hello', text: 'This is my third post', comments_counter: 0, likes_counter: 0)
      Post.create(author: subject, title: 'Hello', text: 'This is my fourth post', comments_counter: 0,
                  likes_counter: 0)
      Post.create(author: subject, title: 'Hello', text: 'This is my fifth post', comments_counter: 0, likes_counter: 0)

      expect(subject.latest_posts[0].text).to eq 'This is my fifth post'
      expect(subject.latest_posts[1].text).to eq 'This is my fourth post'
      expect(subject.latest_posts[2].text).to eq 'This is my third post'
    end
  end
end
