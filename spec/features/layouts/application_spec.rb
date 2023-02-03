require 'rails_helper'

RSpec.describe 'Application Pages' do
  # User Story 8, Beer Index Link

  # As a visitor
  # When I visit any page on the site
  # Then I see a link at the top of the page that takes me to the Beer Index
  describe "As a visitor" do
    describe "when I visit any page on the site" do
      it "can see a link at the top of the page that takes me to the Beers Index" do
        brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
        beer_1 = Beer.create!(brewery: brewery_1, style: "IPA", abv: 6.9, nitro: false)

        visit "/breweries"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/beers"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/#{brewery_1.id}"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/beers/#{beer_1.id}"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/#{brewery_1.id}/beers"
        expect(page).to have_link("Beer Index", href: "/beers")
      end
    end
  end
end