require 'sinatra'
require 'dotenv'
require 'slack-ruby-client'

Dotenv.load
Slack.configure do |config|
  config.token = ENV["SLACKAPIKEY"]
end

get '/' do
  erb :request
end

get '/conversations_history/:id' do
  client = Slack::Web::Client.new
  channel = params[:id]
  @messages = client.conversations_history(channel: channel).to_json
  erb :index
end

post '/request' do
  if params[:channelid] == ""
    redirect '/'
  else
    url = '/conversations_history/' + params[:channelid] 
    redirect url
  end
end