require 'rails_helper'

RSpec.describe 'Breweries Beers Index Page' do
  before(:each) do
    @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
    @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12)

    @beer_1 = Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: @brewery_1)
    @beer_2 = Beer.create!(nitro: false, style: "IPA", abv: 6.2, brewery: @brewery_1)
    @beer_3 = Beer.create!(nitro: false, style: "IPA", abv: 7.0, brewery: @brewery_2)

    visit "/breweries/#{@brewery_1.id}/beers"
  end

  describe "As a visitor" do
    describe "when I visit '/breweries/:brewery_id/beers" do
      it "can see each beer that is associated wit that brewery with each beer's attributes" do
        expect(page).to have_content("Beer ID: #{@beer_1.id}")
        expect(page).to have_content("Beer ID: #{@beer_2.id}")

        expect(page).to have_content("Brewery ID: #{@beer_1.brewery_id}")
        expect(page).to have_content("Brewery ID: #{@beer_2.brewery_id}")
        
        expect(page).to have_content("Created at: #{@beer_1.created_at}")
        expect(page).to have_content("Created at: #{@beer_2.created_at}")
        
        expect(page).to have_content("Updated at: #{@beer_1.updated_at}")
        expect(page).to have_content("Updated at: #{@beer_2.updated_at}")

        expect(page).to have_content("Style: #{@beer_1.style}")
        expect(page).to have_content("Style: #{@beer_2.style}")

        expect(page).to have_content("ABV: #{@beer_1.abv}")
        expect(page).to have_content("ABV: #{@beer_2.abv}")

        expect(page).to have_content("Nitro: #{@beer_1.nitro}")
        expect(page).to have_content("Nitro: #{@beer_2.nitro}")
      end

      it "will not display other brewery's beer attributes" do
        expect(page).to_not have_content(@beer_3.id)
      end

      it 'can see a link to add a new adoptable beer for that brewery titled "Create Beer"' do
        expect(page).to have_link("Create Beer", href: "/breweries/#{@brewery_1.id}/beers/new")

        click_link("Create Beer")

        expect(current_path).to eq("/breweries/#{@brewery_1.id}/beers/new") 
      end

      it 'can see a link to sort children in alphabetical style' do
        expect(page).to have_link("Order Alphabetically", href: "/breweries/#{@brewery_1.id}/beers?ordered=true")

        click_link("Order Alphabetically")

        expect(current_path).to eq("/breweries/#{@brewery_1.id}/beers")
        expect(@beer_2.style).to appear_before(@beer_1.style)
      end

      it 'can see a form to input a threshold value to only display records above that ABV' do
        expect(page).to have_field(:threshold, with: "0")
        expect(page).to have_button("Submit")

        fill_in(:threshold, with: "5.1")
        
        click_button("Submit")

        expect(current_path).to eq("/breweries/#{@brewery_1.id}/beers")
        expect(page).to_not have_content(@beer_1.id)
      end

      it "can see a link next to each beer to delete the beer and return back to the beers table without that beer" do
        expect(page).to have_link("Delete Beer", href: "/beers/#{@beer_1.id}")

        click_link("Delete Beer", match: :first)

        expect(current_path).to eq("/beers")
        expect(page).to_not have_content(@beer_1.id)
      end
    end
  end
end