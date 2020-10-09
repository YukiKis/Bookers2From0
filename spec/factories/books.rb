FactoryBot.define do
  
  factory :book1, class: Book do
    title { Faker::Coffee.blend_name }
    body { Faker::Coffee.origin }
  end

  factory :book2, class: Book do
    title { Faker::Restaurant.name }
    body { Faker::Restaurant.type }
  end
end