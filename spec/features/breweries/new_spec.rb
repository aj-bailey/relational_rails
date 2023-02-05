require 'rails_helper'

RSpec.describe "Breweries New Page", type: :feature do
  describe 'As a visitor' do
    describe 'when I visit /breweries/new' do
      before(:each) do
        visit '/breweries/new'
      end

      it 'can see a form with attributes: barrel_program, name, num_taps' do
        expect(page).to have_content("Name:")
        expect(page).to have_content("Barrel program:")
        expect(page).to have_content("Number of taps:")

        expect(page).to have_field(:name)
        expect(page).to have_field(:barrel_program)
        expect(page).to have_field(:num_taps)
      end
      
      it 'can fill out form and click submit button on form to create new parent record and redirect to /breweries' do
        fill_in(:name, with: "Bonfire Brewing")
        choose('barrel_program_true')
        fill_in(:num_taps, with: "23")

        click_button("Create Brewery")
        expect(Brewery.all.size).to eq(1)
        expect(current_path).to eq("/breweries")
        expect(page).to have_content("Bonfire Brewing")
      end
    end
  end
end