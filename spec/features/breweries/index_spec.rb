require 'rails_helper'

RSpec.describe "Breweries Index Page", type: :feature do
  # For each parent table
  # As a visitor
  # When I visit '/parents'
  # Then I see the name of each parent record in the system
  let!(:brewery_1) { Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23) }
  let!(:brewery_2) { Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12) }

  describe "As a visitor" do
    describe "when I visit '/parents'" do
      it 'can see the name of each parent record in the system' do 
        # brewery_1
        # brewery_2

        visit '/breweries'
        
        expect(page).to have_content(brewery_1.name)
        expect(page).to have_content(brewery_2.name)
      end
    end
  end
end