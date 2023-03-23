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
  # text = "Hello World"
  # client.chat_postMessage(channel: '#slack-contributions-calendar', text: text)
  @messages = client.conversations_history(channel: channel).to_json
  # @json = messages.to_json
  erb :index
end

post '/request' do
  # Slack.configure do |config|
    # config.token = ENV["SLACKAPIKEY"]
    # config.token = params[:key]
  # end
  url = '/conversations_history/' + params[:channelid] 
  redirect url
end