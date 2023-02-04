# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Beer.destroy_all
Brewery.destroy_all


@brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
@brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12)
@brewery_3 = Brewery.create!(name: "Russian River Brewing Company", barrel_program: true, num_taps: 20)

@beer_1 = Beer.create!(brewery: @brewery_1, style: "IPA", abv: 6.9, nitro: false)
@beer_2 = Beer.create!(brewery: @brewery_1, style: "Brown Ale", abv: 5.2, nitro: false)
@beer_3 = Beer.create!(brewery: @brewery_1, style: "Pale Ale", abv: 5.4, nitro: false)
@beer_4 = Beer.create!(brewery: @brewery_1, style: "Stout", abv: 4.9, nitro: true)

@beer_5 = Beer.create!(brewery: @brewery_2, style: "IPA", abv: 7.0, nitro: false)
@beer_6 = Beer.create!(brewery: @brewery_2, style: "Hazy IPA", abv: 6.8, nitro: false)
@beer_7 = Beer.create!(brewery: @brewery_2, style: "ESB", abv: 5.4, nitro: true)
@beer_8 = Beer.create!(brewery: @brewery_2, style: "Kolsch", abv: 5.0, nitro: false)

@beer_9 = Beer.create!(brewery: @brewery_3, style: "IPA", abv: 6.25, nitro: false)
@beer_10 = Beer.create!(brewery: @brewery_3, style: "Double IPA", abv: 8.0, nitro: false)
@beer_11 = Beer.create!(brewery: @brewery_3, style: "Sour Brown Ale", abv: 7.0, nitro: false)
@beer_12 = Beer.create!(brewery: @brewery_3, style: "Pilsner", abv: 5.35, nitro: false)