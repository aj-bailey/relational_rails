require 'rails_helper'

RSpec.describe "Beers Index Page", type: :feature do
  before(:each) do
    @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
    @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12)

    @beer_1 = Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: @brewery_1)
    @beer_2 = Beer.create!(nitro: false, style: "India Pale Ale", abv: 7.0, brewery: @brewery_2)

    visit "/beers"
  end

  describe "As a visitor" do
    describe "when I visit '/beers'" do
      it "can see each beer in the system including the beer's attributes for only nitro beers" do 
        expect(page).to have_content("Beer ID: #{@beer_1.id}")
        expect(page).to have_content("Brewery ID: #{@beer_1.brewery_id}")
        expect(page).to have_content("Created at: #{@beer_1.created_at}")
        expect(page).to have_content("Updated at: #{@beer_1.updated_at}")
        expect(page).to have_content("Style: #{@beer_1.style}")
        expect(page).to have_content("ABV: #{@beer_1.abv}")
        expect(page).to have_content("Nitro: #{@beer_1.nitro}")

        expect(page).to have_content("Beer ID: #{@beer_2.id}")
        expect(page).to have_content("Brewery ID: #{@beer_2.brewery_id}")
        expect(page).to have_content("Created at: #{@beer_2.created_at}")
        expect(page).to have_content("Updated at: #{@beer_2.updated_at}")
        expect(page).to have_content("Style: #{@beer_2.style}")
        expect(page).to have_content("ABV: #{@beer_2.abv}")
        expect(page).to have_content("Nitro: #{@beer_2.nitro}")
      end

      it "can see a link, Show Nitro Beers, to only list nitro beers and their attributes" do
        expect(page).to have_link("Show Nitro Beers", href: "/beers?find=nitro_beers")

        click_link "Show Nitro Beers"

        expect(current_path).to eq("/beers")
        expect(page).to_not have_content(@beer_2.id)
      end
      
      it "can see a link next to each beer leading to their edit page" do
        expect(page).to have_link("Edit Beer", href: "/beers/#{@beer_1.id}/edit")

        click_link "Edit Beer", match: :first

        expect(current_path).to eq("/beers/#{@beer_1.id}/edit")
      end

      it "can see a link next to each beer to delete the beer and return back to the beers table without that beer" do
        expect(page).to have_link("Delete Beer", href: "/beers/#{@beer_1.id}")

        click_link "Delete Beer", match: :first

        expect(current_path).to eq("/beers")
        expect(page).to_not have_content(@beer_1.id)
      end

      it 'can see a text box with a search button to find partial match of text input' do
        beer_3 = Beer.create!(nitro: false, style: "Red Ale", abv: 5.2, brewery: @brewery_1)

        expect(page).to have_field(:partial_match)

        fill_in :partial_match, with: "Ale"
        click_button "Search Partial"

        expect(page).to have_content("India Pale Ale")
        expect(page).to have_content("Red Ale")
        expect(page).to_not have_content("Stout")
      end
    end
  end
end