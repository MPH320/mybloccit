# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include Faker
require 'random_data'
require 'marky_markov'
markov = MarkyMarkov::TemporaryDictionary.new
markov.parse_file "zenfile.txt"

anon = User.create!(
   name:     'Anonymous',
   email:    'Anonymous@sink.sendgrid.net',
   password: 'helloworld'
 )

admin = User.create!(
   name:     'Admin User',
   email:    'admin@sink.sendgrid.net',
   password: 'helloworld',
   role:     'admin'
 )
 
 # Create a member
 member = User.create!(
   name:     'Member User',
   email:    'member@sink.sendgrid.net',
   password: 'helloworld'
 )

5.times do
   User.create!(
 # #3
   name:     Faker::GameOfThrones.character,
   email:    RandomData.random_email,
   password: RandomData.random_sentence
   )
 end
 
 users = User.all

15.times do
   Topic.create!(
     name:        Faker::Company.catch_phrase,
     description: Faker::Hacker.say_something_smart
   )
 end
 
 Topic.create!(
     name:        "This is the name of the topic",
     description: "A topic description goes here. Only admins can create topics. The other topics were magically created with the faker gem."
   )
 topics = Topic.all

10.times do
   SponsoredPost.create!(
     user:   users.second,
     topic:  topics.sample,
     title:  Faker::Hipster.sentence,
     body:   markov.generate_5_sentences,
     price: rand(10...100)
   )
 end
 
  SponsoredPost.create!(
     user:   users.second,
     topic:  topics.first,
     title:  "This is the title of a sponsored post",
     body:   "The body of the post goes here. Only admins can make these.",
     price: rand(10...100)
   )
 
 sponsored_post = SponsoredPost.all
 
 50.times do
   Post.create!(
     user:   users.sample,
     topic:  topics.sample,
     title:  Faker::Hipster.sentence,
     body:   markov.generate_5_sentences
   )
 end
 
  Post.create!(
     user:   users.sample,
     topic:  topics.first,
     title:  "This is a regular post title.",
     body:   "Any member can make these."
   )
 
 posts = Post.all
 
 
 
 100.times do
   Comment.create!(
     user: users.sample,
     post: posts.sample,
     body: Faker::Friends.quote
   )
 end
 
 Comment.create!(
     user: users.sample,
     post: posts.first,
     body: "This is the first comment on a post! Anyone can leave comments."
   )
 

 
 20.times do
   Comment.create!(
     user: users.offset(1).sample,
     sponsored_post: sponsored_post.sample,
     body: Faker::Hacker.say_something_smart
   )
 end
 
  Comment.create!(
     user: users.offset(1).sample,
     sponsored_post: sponsored_post.first,
     body: "I'm the first comment on a sponsored post! These are restricted to members only."
   )
 
 50.times do

    Advertisement.create!(
     title:  Faker::Cat.registry,
     body:   Faker::ChuckNorris.fact,
     url:    Faker::Internet.url,
     price: rand(10...100)
    )
   
 
 end
 
 advertisements = Advertisement.all
 
 puts "Seed finished"
 puts "#{User.count} users created"
 puts "#{Topic.count} topics created"
 puts "#{SponsoredPost.count} sponsored posts created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 markov.clear!