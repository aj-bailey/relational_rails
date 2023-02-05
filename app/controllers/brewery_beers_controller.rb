class BreweryBeersController < ApplicationController
  def index
    @brewery = Brewery.find(params[:brewery_id])
    params[:ordered] == "true" ? @beers = @brewery.beers.order_by_alphabetical_style : @beers = @brewery.beers
  end
  
  def new
    @brewery = Brewery.find(params[:id])
  end

  def create
    brewery = Brewery.find(params[:id])
    beer = Beer.create!(beer_params.merge({brewery_id: brewery.id}))
    redirect_to "/breweries/#{brewery.id}/beers"
  end

  private
  def beer_params
    params.permit(:style, :abv, :nitro)
  end
end