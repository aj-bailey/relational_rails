class BreweryBeersController < ApplicationController
  def index
    @brewery = Brewery.find(params[:brewery_id])

    if params.keys.include?("ordered")
      @beers = @brewery.beers.order_by_alphabetical_style 
    elsif params.keys.include?("threshold")
      @beers = @brewery.beers.list_above_abv(params[:threshold])
    else
      @beers = @brewery.beers
    end
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