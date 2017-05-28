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

15.times do
   Topic.create!(
     name:        Faker::Company.catch_phrase,
     description: markov.generate_5_sentences
   )
 end
 topics = Topic.all

50.times do
   Post.create!(
     topic:  topics.sample,
     title:  Faker::Hipster.sentence,
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
     title:  Faker::Cat.registry,
     body:   Faker::ChuckNorris.fact,
     url:    Faker::Internet.url,
     price: rand(10...100)
    )
   
 
 end
 
 advertisements = Advertisement.all
 
 puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"
 markov.clear!