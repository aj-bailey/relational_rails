require 'rails_helper'

RSpec.describe "Breweries Show Page", type: :feature do
  let!(:brewery_1) { Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23) }
  let!(:brewery_2) { Brewery.create!(name: "Vail Brewing Company", barrel_program: false, num_taps: 12) }

  describe "As a visitor" do
    describe "when I visit '/breweries/:id'" do
      it "can see the brewery with that id including the brewery's attributes" do 
        visit "/breweries/#{brewery_1.id}"
        
        expect(page).to have_content("Brewery ID: #{brewery_1.id}")
        expect(page).to have_content("Created at: #{brewery_1.created_at}")
        expect(page).to have_content("Updated at: #{brewery_1.updated_at}")
        expect(page).to have_content("Barrel Program: #{brewery_1.barrel_program}")
        expect(page).to have_content(brewery_1.name)
        expect(page).to have_content("Number of Taps: #{brewery_1.num_taps}")
      end

      it "will not display other brewery attributes" do
        visit "/breweries/#{brewery_1.id}"

        expect(page).to_not have_content(brewery_2.id)
      end

      it 'can see a count of the number of beers associated with this brewery' do
        visit "/breweries/#{brewery_1.id}"
 
        expect(page).to have_content("Number of Beers: #{brewery_1.num_beers}")
      end

      # User Story 10, Parent Child Index Link

      # As a visitor
      # When I visit a parent show page ('/parents/:id')
      # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')

      it "can see a link to take me to that brewery's beers page" do
        visit "/breweries/#{brewery_1.id}"

        expect(page).to have_link("#{brewery_1.name}'s Beer", href: "/breweries/#{brewery_1.id}/beers")
      end
    end
  end
end