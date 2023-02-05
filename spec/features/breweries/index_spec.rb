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

        click_link "New Brewery"

        expect(current_path).to eq("/breweries/new") 
      end
    end
  end
end