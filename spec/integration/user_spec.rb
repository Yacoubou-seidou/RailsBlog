require 'rails_helper'

RSpec.describe User, type: :system do
  let(:person1) do
    User.new(
      name: 'Seidou',
      photo: 'https://drive.google.com/file/d/13-N8SlsasURapsAjgP0D2KTnYtNGBsxO/view?usp=sharing',
      bio: 'Full Stack Web Developer',
      posts_counter: 0
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

  let(:first_post) do
    Post.create(
      author: person2,
      title: 'Hi there',
      text: 'best post',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:second_post) do
    Post.create(
      author: person2,
      title: 'Holla',
      text: 'Must read',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  let(:third_post) do
    Post.create(
      author: person2,
      title: 'Holla Post',
      text: 'Once again and again',
      likes_counter: 0,
      comments_counter: 0
    )
  end

  before do
    person1.save!
    person2.save!
  end

  context 'User index page test' do
    before { visit root_path }

    it 'shows the profile picture of each user' do
      profile_pictures = all('img.user-image')

      expect(profile_pictures[0]).to be_visible
      expect(profile_pictures[1]).to be_visible
      expect(profile_pictures[0]['src']).to eq person1.photo
      expect(profile_pictures[1]['src']).to eq person2.photo
    end

    it 'shows the username of each user' do
      expect(page).to have_content(person1.name)
      expect(page).to have_content(person2.name)
    end
  end

  context 'index page test' do
    before { visit root_path }

    it 'shows the number of posts each user has written' do
      user_tiles = all('.user-info p')

      user_tiles.each do |user_tile|
        expect(user_tile).to have_content(/ posts: \d+/)
      end
    end

    it 'redirects to a user\'s show page on click' do
      person_show_page_url = "#{Capybara.app_host}/users/#{person1.id}"

      click_link person1.name

      expect(page).to have_current_path(person_show_page_url)
    end
  end
end
