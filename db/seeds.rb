# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# coding: utf-8

Admin.create!(
   email: 'takuma3704@gmail.com',
   password: 'takuma'
)

Genre.create!(
   [
      {name: '化粧水'},
      {name: '美容液'},
      {name: '乳液'},
      {name: 'オールインワンゲル'},
      {name: 'クリーム'},
      {name: '洗顔'},
      {name: 'パック'}
   ]
)

require "csv"

CSV.foreach('db/test2.csv') do |info|
  Item.create(
     :brand => info[0],
     :name => info[1],
     :genre_id => info[2],
     :price => info[3],
     :release_date => info[4],
     :capacity => info[5],
     :introduction => info[6],
     :image =>  info[7]
     )
end