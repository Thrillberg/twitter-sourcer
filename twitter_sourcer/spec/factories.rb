FactoryBot.define do
  factory :twitter_account do
    sequence(:twitter_id) { |n| "twitter_id_#{n}" }
    sequence(:name) { |n| "Twitter Account #{n}" }
    sequence(:screen_name) { |n| "twitter_account_#{n}" }
    friends_count { 12 }

    trait :climate_change_denier do
      after :create do |account|
        create(
          :political_position,
          is_climate_change_denier: true,
          twitter_account: account,
        )
      end
    end
  end
end

FactoryBot.define do
  factory :political_position do
  end
end
