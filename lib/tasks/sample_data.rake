

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users  
    make_relationships
  end
end

def make_users
  User.create!(email: "example@complitech.net",
                 password: "123456789",
                 password_confirmation: "123456789",
                 location: "Ahmedabad",
                 name: "Example User")
    50.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@complitech.net"
      password  = "123456789"
      location = "A'dad"
      User.create!(email: email,
                   password: password,
                   password_confirmation: password,
                   location: location,
                   name: name)
 
    end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..20]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end

