Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  get '/breweries/:id', to: 'breweries#show'
  get '/beers', to: 'beers#index'
  get '/beers/:id', to: 'beers#show'
  get '/breweries/:brewery_id/beers', to: 'brewery_beers#index'
  post '/breweries', to: 'breweries#create'
  get '/breweries/:id/edit', to: 'breweries#edit'
  patch '/breweries/:id', to: 'breweries#update'
  get '/breweries/:id/beers/new', to: 'brewery_beers#new'
  post '/breweries/:id/beers', to: 'brewery_beers#create'
end