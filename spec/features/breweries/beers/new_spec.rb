require "rails_helper"

RSpec.describe "Brewery Beers New Page" do
  describe "As a visitor" do
    describe "when I visit '/breweries/:brewery_id/beers/new" do
      before(:each) do
        @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)

        visit "/breweries/#{@brewery_1.id}/beers/new"
      end

      it "can see a form to add a new adoptable beer with attributes: style, abv, nitro" do
        expect(page).to have_content("Style:")
        expect(page).to have_content("ABV:")
        expect(page).to have_content("Nitro:")

        expect(page).to have_field(:style)
        expect(page).to have_field(:abv)
        expect(page).to have_field(:nitro)
      end

      it "can fill out form and click submit button to create new parent record and redirect to /breweries/:id/beers" do
        fill_in(:style, with: "Stout")
        fill_in(:abv, with: 5.2)
        choose('nitro_true')

        click_button("Create Beer")
        expect(Beer.all.size).to eq(1)
        expect(current_path).to eq("/breweries/#{@brewery_1.id}/beers")
        expect(page).to have_content("Stout")
      end
    end
  end
end
