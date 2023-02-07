require "rails_helper"

RSpec.describe "Welcome Page" do
  it 'has welcome message' do
    visit "/"

    expect(page).to have_content("Welcome to Brewery Manager")
  end  
end