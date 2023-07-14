require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:first_person) do
    User.new(
      name: 'Yacos',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer',
      posts_counter: 0
    )
  end

  let(:subject) do
    Post.create(
      author: first_person,
      title: 'Hello',
      text: 'This is my first post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  context '#title' do
    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should be less than 250 characters' do
      subject.title = (0...300).map { ('a'..'z').to_a[rand(26)] }.join
      expect(subject).to_not be_valid
    end
  end

  context '#comments_counter' do
    it 'comments counter should not be nil' do
      subject.comments_counter = nil
      expect(subject).to_not be_valid
    end

    it 'comments counter should be greater than or equal to 0' do
      subject.comments_counter = -1
      expect(subject).to_not be_valid
    end

    it 'comments counter should accept only integer values' do
      subject.comments_counter = 2.45
      expect(subject).to_not be_valid
    end

    it 'comments counter should accept zero' do
      subject.comments_counter = 0
      expect(subject).to be_valid
    end

    it 'comments counter should accept positive integers' do
      subject.comments_counter = 1
      expect(subject).to be_valid
    end
  end

  context '#likes_counter' do
    it 'likes counter should not be nil' do
      subject.likes_counter = nil
      expect(subject).to_not be_valid
    end

    it 'likes counter should be greater than or equal to 0' do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    it 'likes counter should accept only integer values' do
      subject.likes_counter = 2.45
      expect(subject).to_not be_valid
    end

    it 'likes counter should accept zero' do
      subject.likes_counter = 0
      expect(subject).to be_valid
    end

    it 'likes counter should accept positive values' do
      subject.likes_counter = 1
      expect(subject).to be_valid
    end
  end

  context '#update_post_counter' do
    it 'should increase the author\'s post counter when a post is created' do
      expect { subject.update_post_counter }.to change(first_person, :posts_counter).from(0).to(1)
    end
  end

  context '#most_recent_comments' do
    it 'should return the most recent comments on a post' do
      Comment.create(post: subject, user: first_person, text: 'Hello')
      Comment.create(post: subject, user: first_person, text: 'Hi')
      Comment.create(post: subject, user: first_person, text: 'How are you?')
      Comment.create(post: subject, user: first_person, text: 'Good job')
      Comment.create(post: subject, user: first_person, text: 'Nice code')
      Comment.create(post: subject, user: first_person, text: 'See you!')
      Comment.create(post: subject, user: first_person, text: 'Happy coding')
      Comment.create(post: subject, user: first_person, text: 'bye!!!')

      expect(subject.most_recent_comments[0].text).to eq 'Good job'
      expect(subject.most_recent_comments[1].text).to eq 'Nice code'
      expect(subject.most_recent_comments[2].text).to eq 'See you!'
      expect(subject.most_recent_comments[3].text).to eq 'Happy coding'
      expect(subject.most_recent_comments[4].text).to eq 'bye!!!'
    end
  end
end
