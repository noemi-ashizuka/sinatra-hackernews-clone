require 'faker'

5.times do

  user = User.create!(
    username: Faker::Internet.user_name,
    email: Faker::Internet.email
  )

  (5..10).to_a.sample.times do
    post = Post.create!(
      title: Faker::TvShows::HowIMetYourMother.quote,
      url: Faker::Internet.url,
      votes: rand(0..1000),
      user: user
    )
  end
end
