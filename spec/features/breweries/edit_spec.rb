require "rails_helper"

RSpec.describe "Breweries Edit Page" do
  describe 'As a visitor' do
    describe 'when I visit /breweries/:id/edit' do
      before(:each) do
        @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)

        visit "/breweries/#{@brewery_1.id}/edit"
      end

      it 'can see a form with current attributes: barrel_program, name, num_taps' do
        expect(page).to have_content("Name:")
        expect(page).to have_content("Barrel program:")
        expect(page).to have_content("Number of taps:")


        expect(page).to have_field(:name, with: "Bonfire Brewing")
        expect(page).to have_checked_field(:barrel_program)
        expect(page).to have_field(:num_taps, with: 23)
      end
      
      it 'can fill out form and click submit button on form to create new parent record and redirect to /parents' do
        fill_in(:name, with: "Bonfire Brewing Company")
        choose 'barrel_program_true'
        fill_in(:num_taps, with: "25")

        click_button("Update Brewery")
        expect(Brewery.all.size).to eq(1)
        expect(current_path).to eq("/breweries")
        expect(page).to have_content("Bonfire Brewing Company")
      end
    end
  end
end