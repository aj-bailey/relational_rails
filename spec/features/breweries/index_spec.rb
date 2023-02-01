require 'rails_helper'

RSpec.describe "Breweries Index Page", type: :feature do
  let!(:brewery_1) { Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23) }
  let!(:brewery_2) { Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12) }

  describe "As a visitor" do
    describe "when I visit '/breweries'" do
      it 'can see the name of each brewery record in the system' do 
        visit '/breweries'
        
        expect(page).to have_content(brewery_1.name)
        expect(page).to have_content(brewery_2.name)
      end
    end
  end
end