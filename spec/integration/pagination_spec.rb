require 'rails_helper'

RSpec.feature 'Pagination', type: :feature do
  let(:person) do
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

  before do
    person.save!
  end

  let!(:posts) do
    posts = []
    25.times do
      post = Post.create(
        author: person,
        title: 'A Post',
        text: 'Some content',
        likes_counter: 0,
        comments_counter: 0
      )
      posts << post
    end
    posts
  end

  scenario 'User sees pagination when there are more posts than fit on the view' do
    visit user_posts_path(user_id: person.id)

    expect(page).to have_selector('.pagination')
    expect(page).to have_selector('.pagination a', count: 3)

    click_link '2'

    expect(current_path).to eq(user_posts_path(user_id: person.id))
    expect(page).to have_content(posts.last.title)
  end
end
