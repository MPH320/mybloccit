# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include Faker
require 'random_data'


50.times do
   Post.create!(
     title:  Faker::Company.catch_phrase,
     body:   Faker::Friends.quote
   )
 end
 
 posts = Post.all
 
 100.times do
   Comment.create!(
     post: posts.sample,
     body: Faker::Hacker.say_something_smart
   )
 end
 
 50.times do

    Advertisement.create!(
     title:  Faker::ChuckNorris.fact,
     body:   Faker::Company.catch_phrase,
     url:    Faker::Internet.url,
     price: rand(10...100)
    )
   
 
 end
 
 advertisements = Advertisement.all
 
  puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"