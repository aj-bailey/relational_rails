require 'rails_helper'

RSpec.describe 'Application Pages' do
  describe "As a visitor" do 
    describe "when I visit any page on the site" do
      before(:each) do
        @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
        @beer_1 = Beer.create!(brewery: @brewery_1, style: "IPA", abv: 6.9, nitro: false)
      end

      it "can see a link at the top of the page that takes me to the Beer Index" do
        visit "/beers"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/beers/#{@beer_1.id}"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/beers/#{@beer_1.id}/edit"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/new"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/#{@brewery_1.id}"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/#{@brewery_1.id}/edit"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/#{@brewery_1.id}/beers"
        expect(page).to have_link("Beer Index", href: "/beers")

        visit "/breweries/#{@brewery_1.id}/beers/new"
        expect(page).to have_link("Beer Index", href: "/beers")
      end

      it "can see a link at the top of the page that takes me to the Brewery Index" do
        visit "/beers"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/beers/#{@beer_1.id}"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/beers/#{@beer_1.id}/edit"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/breweries"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/breweries/new"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/breweries/#{@brewery_1.id}"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/breweries/#{@brewery_1.id}/edit"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/breweries/#{@brewery_1.id}/beers"
        expect(page).to have_link("Brewery Index", href: "/breweries")

        visit "/breweries/#{@brewery_1.id}/beers/new"
        expect(page).to have_link("Brewery Index", href: "/breweries")
      end

      it "can see a link at the top of the page that takes me to the Home page" do
        visit "/beers"
        expect(page).to have_link("Home", href: "/")

        visit "/beers/#{@beer_1.id}"
        expect(page).to have_link("Home", href: "/")

        visit "/beers/#{@beer_1.id}/edit"
        expect(page).to have_link("Home", href: "/")

        visit "/breweries"
        expect(page).to have_link("Home", href: "/")

        visit "/breweries/new"
        expect(page).to have_link("Home", href: "/")

        visit "/breweries/#{@brewery_1.id}"
        expect(page).to have_link("Home", href: "/")

        visit "/breweries/#{@brewery_1.id}/edit"
        expect(page).to have_link("Home", href: "/")

        visit "/breweries/#{@brewery_1.id}/beers"
        expect(page).to have_link("Home", href: "/")

        visit "/breweries/#{@brewery_1.id}/beers/new"
        expect(page).to have_link("Home", href: "/")
      end
    end
  end
end