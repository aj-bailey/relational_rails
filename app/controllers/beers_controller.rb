class BeersController < ApplicationController
  def index
    if params[:exact_match]
      @beers = Beer.exact_match(params[:exact_match])
    elsif params[:partial_match]
      @beers = Beer.partial_match(params[:partial_match])
    elsif params[:find] == "nitro_beers"
      @beers = Beer.list_by_nitro_true
    else
      @beers = Beer.all
    end
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def edit
    @beer = Beer.find(params[:id])
  end

  def update
    beer = Beer.find(params[:id])
    beer.update(beer_params)
    redirect_to "/beers/#{beer.id}"
  end

  def delete
    beer = Beer.find(params[:id])
    beer.delete
    redirect_to "/beers"
  end

  private
  def beer_params
    params.permit(:style, :abv, :nitro)
  end
end