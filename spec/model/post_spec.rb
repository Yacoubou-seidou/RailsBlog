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

  before { subject.save }
  let(:subject) do
    Post.new(
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
      coment1 = Comment.new(post: subject, user: first_person, text: 'Hello')
      coment2 = Comment.new(post: subject, user: first_person, text: 'Hi')
      coment3 = Comment.new(post: subject, user: first_person, text: 'How are you?')
      coment4 = Comment.new(post: subject, user: first_person, text: 'Good job')
      coment5 = Comment.new(post: subject, user: first_person, text: 'Nice code')
      coment6 = Comment.new(post: subject, user: first_person, text: 'See you!')
      coment7 = Comment.new(post: subject, user: first_person, text: 'Happy coding')
      coment8 = Comment.new(post: subject, user: first_person, text: 'bye!!!')
      subject.comments = [coment1, coment2, coment3, coment4, coment5, coment6, coment7, coment8]

      expect(subject.most_recent_comments).to eq [coment4, coment5, coment6, coment7, coment8]
    end
  end
end
