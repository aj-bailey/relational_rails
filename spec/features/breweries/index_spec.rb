require 'rails_helper'

RSpec.describe "Breweries Index Page", type: :feature do
  describe "As a visitor" do
    before(:each) do
      @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23, created_at: Date.new)
      @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12, created_at: Date.new.next)

      visit '/breweries'
    end

    describe "when I visit '/breweries'" do
      it 'can see the name of each brewery record in the system' do 
        expect(page).to have_content(@brewery_1.name)
        expect(page).to have_content(@brewery_2.name)
      end

      it 'can see that records are ordered by most recently created first' do
        expect(@brewery_2.name).to appear_before(@brewery_1.name)
      end

      it 'can see when it was created next to each record' do
        expect(page).to have_content(@brewery_1.created_at)
        expect(page).to have_content(@brewery_2.created_at)
      end

      it 'can see a link to create a new Brewery record, "New Brewery", to be taken to /breweries/new' do
        expect(page).to have_link("New Brewery", href: "/breweries/new")

        click_link("New Brewery")

        expect(current_path).to eq("/breweries/new") 
      end

      it "can see a link next to each brewery leading to their edit page" do
        expect(page).to have_link("Edit Brewery", href: "/breweries/#{@brewery_1.id}/edit")
        expect(page).to have_link("Edit Brewery", href: "/breweries/#{@brewery_2.id}/edit")

        click_link("Edit Brewery", match: :first)

        expect(current_path).to eq("/breweries/#{@brewery_2.id}/edit")
      end

      it 'can see a link that deletes the brewery and returns to the index page without that parent' do
        expect(page).to have_link("Delete Brewery", href: "/breweries/#{@brewery_1.id}")
        expect(page).to have_link("Delete Brewery", href: "/breweries/#{@brewery_2.id}")

        click_link("Delete Brewery", match: :first)

        expect(current_path).to eq("/breweries")
        expect(page).to_not have_content(@brewery_2.name)
      end
      
      it 'can see a link, Order by Number of Beers, to sort breweries by their number of beers and redirect to "/breweries with number beers listed for each"' do
        brewery_3 = Brewery.create!(name: "Russian River Brewing Company", barrel_program: true, num_taps: 20)

        beer_1 = Beer.create!(brewery: @brewery_1, style: "IPA", abv: 6.9, nitro: false)
        beer_2 = Beer.create!(brewery: @brewery_1, style: "Brown Ale", abv: 5.2, nitro: false)

        beer_3 = Beer.create!(brewery: @brewery_2, style: "IPA", abv: 7.0, nitro: false)
        beer_4 = Beer.create!(brewery: @brewery_2, style: "Hazy IPA", abv: 6.8, nitro: false)
        beer_5 = Beer.create!(brewery: @brewery_2, style: "ESB", abv: 5.4, nitro: true)

        beer_9 = Beer.create!(brewery: brewery_3, style: "IPA", abv: 6.25, nitro: false)
        beer_10 = Beer.create!(brewery: brewery_3, style: "Double IPA", abv: 8.0, nitro: false)
        beer_11 = Beer.create!(brewery: brewery_3, style: "Sour Brown Ale", abv: 7.0, nitro: false)
        beer_12 = Beer.create!(brewery: brewery_3, style: "Pilsner", abv: 5.35, nitro: false)

        expect(page).to have_link("Order by Number of Beers", href: "/breweries?order_by=num_beers")

        click_link "Order by Number of Beers"

        expect(current_path).to eq("/breweries")

        expect("Number of beers: 4").to appear_before("Number of beers: 3")
        expect("Number of beers: 3").to appear_before("Number of beers: 2")
      end

      it 'can see a text box with a search button to find exact match of text input' do
        expect(page).to have_field(:exact_match)

        fill_in :exact_match, with: "Bonfire Brewing"

        click_button "Search Exact"

        expect(page).to have_content("Bonfire Brewing")
        expect(page).to_not have_content("Vail Brewing Company")
      end

      it 'can see a text box with a search button to find partial match of text input' do
        brewery_3 = Brewery.create!(name: "Russian River Brewing Company", barrel_program: true, num_taps: 20)
        
        expect(page).to have_field(:partial_match)

        fill_in :partial_match, with: "Company"
        click_button "Search Partial"

        expect(page).to have_content("Russian River Brewing Company")
        expect(page).to have_content("Vail Brewing Company")
        expect(page).to_not have_content("Bonfire Brewing")
      end
    end
  end
end