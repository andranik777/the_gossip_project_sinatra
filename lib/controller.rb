require 'bundler'
require 'gossip'
Bundler.require

class ApplicationController < Sinatra::Base
  
  get '/' do
    erb :index, locals: {gossips: Gossip.all}
  end
  
  get '/gossips/new/' do
    erb :new_gossip
  end
  
  post '/gossips/new/' do
    Gossip.new(params["gossip_author"], params["gossip_content"]).save
    redirect '/'
  end
  
  get '/gossips/:id/' do
    gossip_id = params['id']
    gossip_object = Gossip.find(gossip_id.to_i)
    erb :show, locals: {gossip: gossip_object, id: gossip_id}
  end
  
  get '/gossips/:id/edit/' do
    erb :edit, locals: {id: params['id']}
  end

end