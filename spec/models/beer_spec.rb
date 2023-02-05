require 'rails_helper'

RSpec.describe Beer, type: :model do
  describe 'relationships' do
    it { should belong_to :brewery }
  end

  describe 'class methods' do
    describe '#list_by_nitro_true' do
      before(:each) do
        @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23, created_at: Date.new)

        @beer_1 = Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: @brewery_1)
        @beer_2 = Beer.create!(nitro: false, style: "IPA", abv: 6.9, brewery: @brewery_1)
        @beer_3 = Beer.create!(nitro: true, style: "ESB", abv: 5.3, brewery: @brewery_1)
      end

      it 'retrieves all beer records where nitro column is true' do
        expect(Beer.list_by_nitro_true).to eq([@beer_1, @beer_3])
      end
    end
  end
end