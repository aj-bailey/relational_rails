require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe 'class methods' do
    before(:each) do
      @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
      sleep(1)
      @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12)
      sleep(1)
      @brewery_3 = Brewery.create!(name: "Russian River Brewing Company", barrel_program: true, num_taps: 20)
    end

    describe '#self.order_by_most_recently_created' do
      it 'retrieves list of breweries orderd by most recently created' do
        expect(Brewery.order_by_most_recently_created).to eq([@brewery_3, @brewery_2, @brewery_1])
      end
    end
  end
end