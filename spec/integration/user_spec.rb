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
context 'User show page test' do
  subject { person2 }

  before do
    first_post
    second_post
    third_post
    visit user_path subject
  end

  it 'shows the user profile picture' do
    profile_picture = find('img')

    expect(profile_picture).to be_visible
    expect(profile_picture['src']).to eq subject.photo
  end

  it 'shows the user\'s name' do
    expect(page).to have_content(subject.name)
  end

  it 'shows the number of posts the user has written' do
    expect(page).to have_content(subject.posts_counter.to_s)
  end

  it 'shows the user bio' do
    expect(page).to have_content(subject.bio)
  end

  it 'shows the user\'s first three posts' do
    expect(page).to have_content(subject.posts[0].title)
    expect(page).to have_content(subject.posts[1].title)
    expect(page).to have_content(subject.posts[2].title)
  end

  it 'shows a button that shows all the user\'s Posts when clicked' do
    expect(page).to have_button('See all Posts')
  end

  it 'redirects to the show page of a post when it is clicked' do
    first_post_url = "#{Capybara.app_host}/users/#{subject.id}/posts/#{subject.posts.first.id}"

    click_link subject.posts.first.title

    expect(page).to have_current_path(first_post_url)
    expect(page).to have_content(subject.posts.first.title)
    expect(page).to have_content(subject.posts.first.text)
  end

  it 'redirects to the post\'s index page when the \'see all Posts\' button is clicked' do
    all_posts_url = "#{Capybara.app_host}/users/#{subject.id}/posts"
    click_button 'See all Posts'
    expect(page).to have_current_path(all_posts_url)
  end
end