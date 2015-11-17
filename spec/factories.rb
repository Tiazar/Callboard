FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com"}
    sequence(:login) { |n| "Test_User_#{n}"}
    birthday			        "10.10.2000"
    address				        "Example street, 15"
    city				          "Saint-Petersburg"
    state 				        "Example State"
    country				        "Russia"
    zip   				        "654321"
    password              "foobar"
    password_confirmation "foobar"


    factory :admin do
        admin true
    end
  end

  factory :post do
    content "Lorem ipsum"
    user
  end

  factory :comment do
   content "Lorem ipsum"
   post
  end
end
