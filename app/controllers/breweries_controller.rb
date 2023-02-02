class BreweriesController < ApplicationController
  def index
    @breweries = Brewery.all.order(created_at: :desc)
  end
`-`
  def show
    @brewery = Brewery.find(params[:id])
  end
end