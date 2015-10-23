namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name:                  "Example User",
                 email:                 "example@railstutorial.org",
                 password:              "foobar",
                 password_confirmation: "foobar",
                 login: 				        "Test_User",
                 birthday:		          "12.07.1989",
                 address:				        "Example street, 15",
                 city:				          "Saint-Petersburg",
                 state: 				        "Example State",
                 country:				        "Russia",
                 zip:   				        "654321",
                 )
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      login = "Test_User-#{n+1}"
      if n <=9
        birthday = "10.10.190#{n}"
      else
        birthday = "10.10.19#{n}"
      end
      address = "Example street, 1#{n+1}"
      city ="Saint-Petersburg"
      state =	"Example State"
      country = "Russia"
      zip = 999900 + n
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password,
                   login: 				        login,
                   birthday:		          birthday,
                   address:				        address,
                   city:				          city,
                   state: 				        state,
                   country:				        country,
                   zip:   				        zip,
                   )
    end
  end
end
