Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  delete '/breweries/:id', to: 'breweries#delete'

  get '/beers', to: 'beers#index'
  get '/beers/:id', to: 'beers#show'
  get '/beers/:id/edit', to: 'beers#edit'

  get '/breweries', to: 'breweries#index'
  get '/breweries/new', to: 'breweries#new'
  get '/breweries/:id', to: 'breweries#show'
  get '/breweries/:brewery_id/beers', to: 'brewery_beers#index'
  get '/breweries/:id/beers/new', to: 'brewery_beers#new'
  get '/breweries/:id/edit', to: 'breweries#edit'

  patch '/beers/:id', to: 'beers#update'
  patch '/breweries/:id', to: 'breweries#update'

  post '/breweries', to: 'breweries#create'
  post '/breweries/:id/beers', to: 'brewery_beers#create'
end