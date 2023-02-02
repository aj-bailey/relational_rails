require 'rails_helper'

RSpec.describe "Beers Index Page", type: :feature do
  # User Story 3, Child Index 

  # As a visitor
  # When I visit '/child_table_name'
  # Then I see each Child in the system including the Child's attributes
  # (data from each column that is on the child table)
  let!(:brewery_1) { Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23) }
  let!(:brewery_2) { Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12) }

  let!(:beer_1) { Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: brewery_1) }
  let!(:beer_2) { Beer.create!(nitro: false, style: "IPA", abv: 7.0, brewery: brewery_2) }

  describe "As a visitor" do
    describe "when I visit '/beers'" do
      it "can see each beer in the system including the beer's attributes" do 
        visit "/beers"
        
        expect(page).to have_content("Beer ID: #{beer_1.id}")
        expect(page).to have_content("Beer ID: #{beer_2.id}")

        expect(page).to have_content("Brewery ID: #{beer_1.brewery_id}")
        expect(page).to have_content("Brewery ID: #{beer_2.brewery_id}")
        
        expect(page).to have_content("Created at: #{beer_1.created_at}")
        expect(page).to have_content("Created at: #{beer_2.created_at}")
        
        expect(page).to have_content("Updated at: #{beer_1.updated_at}")
        expect(page).to have_content("Updated at: #{beer_2.updated_at}")

        expect(page).to have_content("Style: #{beer_1.style}")
        expect(page).to have_content("Style: #{beer_2.style}")

        expect(page).to have_content("ABV: #{beer_1.abv}")
        expect(page).to have_content("ABV: #{beer_2.abv}")

        expect(page).to have_content("Nitro: #{beer_1.nitro}")
        expect(page).to have_content("Nitro: #{beer_2.nitro}")
      end
    end
  end
end