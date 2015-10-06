FactoryGirl.define do
  factory :user do
  	login 				  "Test_User"
    name     	  "Michael Hartl"
    email         	"michael@example.com"
    birthday			  "12.07.1989"
    address				  "Example street, 15"
    city				    "Saint-Petersburg"
    state 				  "Example State"
    country				  "Russia"
    zip   				  "654321"
    password              "foobar"
    password_confirmation "foobar"
  end
end

  