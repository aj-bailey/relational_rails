require "rails_helper"

RSpec.describe "Beers Edit Page" do
  describe "as a visitor" do
    describe "when I visit a '/beers/:id/edit'" do
      before(:each) do
        @brewery_1 = Brewery.create!(name: "Bonfire Brewing", barrel_program: true, num_taps: 23)
        @beer_1 = Beer.create!(nitro: true, style: "Stout", abv: 4.9, brewery: @brewery_1)

        visit "/beers/#{@beer_1.id}/edit"
      end

      it 'can see a form with current attributes: style, abv, nitro' do
        expect(page).to have_content("Style:")
        expect(page).to have_content("ABV:")
        expect(page).to have_content("Nitro:")


        expect(page).to have_field(:style, with: "Stout")
        expect(page).to have_field(:abv, with: 4.9)
        expect(page).to have_checked_field(:nitro)
      end

      it 'can fill out the form and click submit button on form to update beer record and redirect to /beers/:id' do
        fill_in(:style, with: "ESB")
        fill_in(:abv, with: "5.4")
        
        click_button("Update Beer")

        expect(Beer.all.size).to eq(1)
        expect(current_path).to eq("/beers/#{@beer_1.id}")
        expect(page).to have_content("ESB")
        expect(page).to have_content("5.4")
      end
    end
  end
end