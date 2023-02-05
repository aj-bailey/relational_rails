require 'rails_helper'

RSpec.describe "Breweries Show Page", type: :feature do
  before(:each) do
    @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
    @brewery_2 = Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12)
    
    visit "/breweries/#{@brewery_1.id}"
  end

  describe "As a visitor" do
    describe "when I visit '/breweries/:id'" do
      it "can see the brewery with that id including the brewery's attributes" do 
        expect(page).to have_content("Brewery ID: #{@brewery_1.id}")
        expect(page).to have_content("Created at: #{@brewery_1.created_at}")
        expect(page).to have_content("Updated at: #{@brewery_1.updated_at}")
        expect(page).to have_content("Barrel Program: #{@brewery_1.barrel_program}")
        expect(page).to have_content(@brewery_1.name)
        expect(page).to have_content("Number of Taps: #{@brewery_1.num_taps}")
      end

      it "will not display other brewery attributes" do
        expect(page).to_not have_content(@brewery_2.id)
      end

      it 'can see a count of the number of beers associated with this brewery' do
        expect(page).to have_content("Number of Beers: #{@brewery_1.num_beers}")
      end

      it "can see a link to take me to that brewery's beers page" do
        expect(page).to have_link("#{@brewery_1.name}'s Beer", href: "/breweries/#{@brewery_1.id}/beers")
      end

      it 'can see a link to update the brewery "Update Brewery", to be taken to /breweries/:id/edit' do
        expect(page).to have_link("Update Brewery", href: "/breweries/#{@brewery_1.id}/edit")

        click_link("Update Brewery")

        expect(current_path).to eq("/breweries/#{@brewery_1.id}/edit")
      end
    end
  end
end