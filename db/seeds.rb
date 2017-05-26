# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
include Faker
require 'marky_markov'
markov = MarkyMarkov::TemporaryDictionary.new
markov.parse_file "zenfile.txt"
require 'random_data'

50.times do
   Post.create!(
     title:  Faker::Company.catch_phrase,
     body:   markov.generate_5_sentences
   )
 end
 
 posts = Post.all
 
 100.times do
   Comment.create!(
     post: posts.sample,
     body: Faker::ChuckNorris.fact
   )
 end
 
 50.times do

    Advertisement.create!(
     title:  Faker::Company.buzzword,
     body:   Faker::Company.catch_phrase,
     price: rand(10...100)
    )
   
 
 end
 
 advertisements = Advertisement.all
 
  puts "Seed finished"
 puts "#{Post.count} posts created"
 puts "#{Comment.count} comments created"