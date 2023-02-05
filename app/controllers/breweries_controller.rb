class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.order_by_most_recently_created
  end

  def show
    @brewery = Brewery.find(params[:id])
  end

  def new
  end

  def create
    brewery = Brewery.create!(brewery_params)
    redirect_to "/breweries"
  end

  def edit
    @brewery = Brewery.find(params[:id])
  end

  def update
    brewery = Brewery.find(params[:id])

    brewery.update(brewery_params)

    redirect_to "/breweries"
  end

  def delete
    brewery = Brewery.find(params[:id])
    beer = Beer.where(brewery_id: brewery.id)
    beer.delete_all
    brewery.delete
    redirect_to "/breweries"
  end

  private
  def brewery_params
    params.permit(:name, :barrel_program, :num_taps)
  end
end