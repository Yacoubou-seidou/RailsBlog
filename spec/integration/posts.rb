FactoryBot.define do
  factory :post do
    association :author, factory: :user
    title { 'A Post' }
    text { 'Some content' }
    likes_counter { 0 }
    comments_counter { 0 }
  end
end
