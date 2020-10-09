FactoryBot.define do

  factory :user1, class: User do
    name { "yuki"}
    email { "yuki@com.com" }
    password { "testtest" }
    password_confirmation { "testtest" }
    introduction { "I AM OK" }
  end

  factory :user2, class: User do
    name { "yuna" }
    email { "yuna@com" }
    password{ "testtest" }
    passwrod_confirmation { "testtest" }
    introduction { "WHO ARE YOU ?" }
  end

end