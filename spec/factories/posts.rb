FactoryBot.define do
  factory :post do
    user { nil }
    title { "MyString" }
    body { "MyText" }
    country { "MyString" }
    region { "MyString" }
    visited_at { "2025-12-21" }
    warning { "MyText" }
    is_public { false }
  end
end
