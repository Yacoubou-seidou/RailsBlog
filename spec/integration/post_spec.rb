require 'rails_helper'

RSpec.describe Post, type: :system do
  let(:person) do
    User.new(
      name: 'Yacos',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer',
      posts_counter: 0
    )
  end

  let(:first_post) do
    Post.create(
      author: person,
      title: 'My post',
      text: 'We testing',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:second_post) do
    Post.new(
      author: person,
      title: 'Another Post',
      text: 'Once again',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:person2) do
    User.new(
      name: 'Ali',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Junior developer',
      posts_counter: 0
    )
  end

  let(:first_comment) do
    Comment.create(
      user: person2,
      post: first_post,
      text: 'Ohhhhh!'
    )
  end

  let(:second_comment) do
    Comment.create(
      user: person2,
      post: first_post,
      text: 'I like it!'
    )
  end

  before do
    person.save!
    person2.save!
    first_post
    second_post
    first_comment
    second_comment
  end

  context 'User Post index page test' do
    subject { person }

    before { visit user_posts_path subject }

    it 'shows the user\'s profile picture' do
      profile_picture = find('img')

      expect(profile_picture).to be_visible
      expect(profile_picture['src']).to eq subject.photo
    end

    it 'shows the user\'s name' do
      expect(page).to have_content(subject.name)
    end

    it ' shows the number of posts the user has written' do
      expect(page).to have_content(subject.posts_counter.to_s)
    end

    it 'shows a post\'s title' do
      expect(page).to have_content(subject.posts.first.title)
    end

    it 'shows some of a post\'s body' do
      expect(page).to have_content(subject.posts.first.text[0..100])
    end

    it 'shows the first comments on a post' do
      expect(page).to have_content(subject.posts.first.comments.first.user.name)
      expect(page).to have_content(subject.posts.first.comments.first.text[0..30])
    end

    it 'shows how many likes a post has' do
      expect(page).to have_content("Likes: #{subject.posts.first.likes_counter}")
    end

    it 'shows how many comments a post has' do
      expect(page).to have_content("Comments: #{subject.posts.first.comments_counter}")
    end
  end

  context 'Post show page' do
    subject { first_post }

    before { visit user_post_path(user_id: person.id, id: subject.id) }

    it 'shows the title of the post' do
      expect(page).to have_content(subject.title)
    end

    it 'shows the author of the post' do
      expect(page).to have_content(subject.author.name)
    end

    it 'shows the number of comments on the post' do
      expect(page).to have_content(subject.comments_counter)
    end

    it 'shows the number of likes on the post' do
      expect(page).to have_content(subject.likes_counter)
    end

    it 'shows the body of the post' do
      expect(page).to have_content(subject.text)
    end

    it 'shows the username of each commentor' do
      subject.comments.each do |comment|
        expect(page).to have_content(comment.user.name)
      end
    end

    it 'shows the comment left by each commentor' do
      subject.comments.each do |comment|
        expect(page).to have_content(comment.text)
      end
    end
  end
end
