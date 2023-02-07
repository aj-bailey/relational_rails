class BreweriesController < ApplicationController
  def index
    @order_by = params[:order_by]

    if params[:order_by] == "num_beers"
      @breweries = Brewery.order_by_num_beers_descending
      @order_by = params[:order_by]
    elsif params[:exact_match] != nil
      @breweries = Brewery.exact_match(params[:exact_match])
    elsif params[:partial_match] != nil
      @breweries = Brewery.partial_match(params[:partial_match])
    else
      @breweries = Brewery.order_by_most_recently_created      
    end
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