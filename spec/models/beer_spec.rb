require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'relationships' do
    it { should belong_to :brewery }
  end

  describe 'class methods' do
    before(:each) do
      @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23, created_at: Date.new)

      @beer_1 = Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: @brewery_1)
      @beer_2 = Beer.create!(nitro: false, style: "India Pale Ale", abv: 6.9, brewery: @brewery_1)
      @beer_3 = Beer.create!(nitro: true, style: "Red Ale", abv: 5.3, brewery: @brewery_1)
    end

    describe '::list_by_nitro_true' do
      it 'retrieves all beer records where nitro column is true' do
        expect(Beer.list_by_nitro_true).to eq([@beer_1, @beer_3])
      end
    end

    describe '::order_by_alphabetical_style' do
      it 'orders all beer records by alphabetical' do
        expect(Beer.order_by_alphabetical_style).to eq([@beer_2, @beer_3, @beer_1])
      end
    end

    describe '::list_above_abv' do
      it 'retrieves all beer records above argument abv' do
        expect(Beer.list_above_abv(5.0)).to eq([@beer_2, @beer_3])
      end
    end

    describe '::exact_match' do
      it 'retrieves list of beers with exact match for style' do
        expect(Beer.exact_match("Stout")).to eq([@beer_1])
      end
    end

    describe '::partial_match' do
      it 'retrieves list of breweries with partial match for name' do
        expect(Beer.partial_match("Ale")).to eq([@beer_2, @beer_3])
      end
    end
  end
end