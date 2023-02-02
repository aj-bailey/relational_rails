class BreweryBeersController < ApplicationController
  def index
    @brewery = Brewery.find(params[:brewery_id])
    @beers = @brewery.beers    
  end
end