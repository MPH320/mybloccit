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

Topic.create!(
     name:        "This is the name of the topic",
     description: "A topic description goes here. The other topics were created automatically"
   )

15.times do
   Topic.create!(
     name:        Faker::Company.catch_phrase,
     description: Faker::Hacker.say_something_smart
   )
 end
 topics = Topic.all
 
 SponsoredPost.create!(
     topic:  topics.first,
     title:  "This is the title of a sponsored post",
     body:   "The body of the post goes here",
     price: rand(10...100)
   )

10.times do
   SponsoredPost.create!(
     topic:  topics.sample,
     title:  Faker::Hipster.sentence,
     body:   markov.generate_5_sentences,
     price: rand(10...100)
   )
 end
 
 sponsored_post = SponsoredPost.all
 
 Post.create!(
     topic:  topics.first,
     title:  "This is a regular post title",
     body:   "Other posts are created using the faker gem"
   )
 
 50.times do
   Post.create!(
     topic:  topics.sample,
     title:  Faker::Hipster.sentence,
     body:   markov.generate_5_sentences
   )
 end
 
 posts = Post.all
 
 Comment.create!(
     post: posts.first,
     body: "This is the first comment on a post!"
   )
 
 100.times do
   Comment.create!(
     post: posts.sample,
     body: Faker::Friends.quote
   )
 end
 
 Comment.create!(
     sponsored_post: sponsored_post.first,
     body: "I'm the first comment on a sponsored post!"
   )
 
 20.times do
   Comment.create!(
     sponsored_post: sponsored_post.sample,
     body: Faker::Hacker.say_something_smart
   )
 end
 
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
 puts "#{Topic.count} topics created"
 puts "#{SponsoredPost.count} sponsored posts created"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 markov.clear!