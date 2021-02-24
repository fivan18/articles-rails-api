FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "fivan#{n}" }
    name "Ivancito"
    url "http://example.com"
    avatar_url "http://example.com/avatar"
    provider "github"
  end
end