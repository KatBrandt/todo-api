FactoryBot.define do
  factory :item do
    name { Faker::Movies::HarryPotter.character }
    done { false }
    todo { nil }
  end
end
