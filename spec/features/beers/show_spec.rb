require 'rails_helper'

RSpec.describe "Beers Show Page", type: :feature do
  before(:each) do
    @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
    @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12)

    @beer_1 = Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: @brewery_1)
    @beer_2 = Beer.create!(nitro: false, style: "IPA", abv: 7.0, brewery: @brewery_2)

    visit "/beers/#{@beer_1.id}"
  end

  describe "As a visitor" do
    describe "when I visit '/beers/:id'" do
      it "can see the beer with that id including the beer's attributes" do       
        expect(page).to have_content("Beer ID: #{@beer_1.id}")
        expect(page).to have_content("Brewery ID: #{@beer_1.brewery_id}")
        expect(page).to have_content("Created at: #{@beer_1.created_at}")
        expect(page).to have_content("Updated at: #{@beer_1.updated_at}")
        expect(page).to have_content("Style: #{@beer_1.style}")
        expect(page).to have_content("ABV: #{@beer_1.abv}")
        expect(page).to have_content("Nitro: #{@beer_1.nitro}")
      end

      it "will not display other beer attributes" do
        expect(page).to_not have_content(@beer_2.id)
      end

      it 'can see a link, "Update Beer", to update a beer record and be taken to /beers/:id/edit' do
        expect(page).to have_link("Update Beer", href: "/beers/#{@beer_1.id}/edit")

        click_link "Update Beer"

        expect(current_path).to eq("/beers/#{@beer_1.id}/edit") 
      end

      it 'can see a link, "Delete Beer", to delete a beer record and be taken to /beers' do
        expect(page).to have_link("Delete Beer", href: "/beers/#{@beer_1.id}")

        click_link("Delete Beer")

        expect(current_path).to eq("/beers")
        expect(page).to_not have_content(@beer_1.id)
      end
    end
  end
end