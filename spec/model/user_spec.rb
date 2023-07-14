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
end
