require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe 'relationships' do
    it { should have_many :beers }
  end

  describe 'class methods' do
    before(:each) do
      @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23, created_at: Date.new)
      @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12, created_at: Date.new.next)
      @brewery_3 = Brewery.create!(name: "Russian River Brewing Company", barrel_program: true, num_taps: 20, created_at: Date.new.next.next)
    end

    describe '::order_by_most_recently_created' do
      it 'retrieves list of breweries orderd by most recently created' do
        expect(Brewery.order_by_most_recently_created).to eq([@brewery_3, @brewery_2, @brewery_1])
      end
    end

    describe '::order_by_num_beers_descending' do
      it 'orders breweries by number of beers in ascending order' do
        beer_1 = Beer.create!(brewery: @brewery_1, style: "IPA", abv: 6.9, nitro: false)
        beer_2 = Beer.create!(brewery: @brewery_1, style: "Brown Ale", abv: 5.2, nitro: false)

        beer_3 = Beer.create!(brewery: @brewery_2, style: "IPA", abv: 7.0, nitro: false)
        beer_4 = Beer.create!(brewery: @brewery_2, style: "Hazy IPA", abv: 6.8, nitro: false)
        beer_5 = Beer.create!(brewery: @brewery_2, style: "ESB", abv: 5.4, nitro: true)

        beer_9 = Beer.create!(brewery: @brewery_3, style: "IPA", abv: 6.25, nitro: false)
        beer_10 = Beer.create!(brewery: @brewery_3, style: "Double IPA", abv: 8.0, nitro: false)
        beer_11 = Beer.create!(brewery: @brewery_3, style: "Sour Brown Ale", abv: 7.0, nitro: false)
        beer_12 = Beer.create!(brewery: @brewery_3, style: "Pilsner", abv: 5.35, nitro: false)

        expect(Brewery.order_by_num_beers_descending).to eq([@brewery_3, @brewery_2, @brewery_1])
      end
    end
  end

  describe 'instance methods' do
    describe '#num_beers' do
      it 'can return the number of beers the brewery has' do
        @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
        @beer_1 = Beer.create!(brewery: @brewery_1, style: "IPA", abv: 6.9, nitro: false)
        @beer_2 = Beer.create!(brewery: @brewery_1, style: "Brown Ale", abv: 5.2, nitro: false)
        @beer_3 = Beer.create!(brewery: @brewery_1, style: "Pale Ale", abv: 5.4, nitro: false)
        @beer_4 = Beer.create!(brewery: @brewery_1, style: "Stout", abv: 4.9, nitro: true)
        
        expect(@brewery_1.num_beers).to eq(4)
      end
    end
  end
end