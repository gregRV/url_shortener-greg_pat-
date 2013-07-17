require 'base64'
require 'securerandom'

get '/' do
  @recent = Url.all
  erb :index
end

post '/urls' do
  @recent = Url.all
  #create new url object and save it to the database
  #create securerandom string
  #append string to fitly
  #pass this in to Url create
  random_str = SecureRandom.base64(6)
  short_url = random_str
  @url = Url.new(:full_url => params[:full_url], :short_url => short_url)
  if @url.save
    redirect "/#{@url.short_url}"
  else
    erb :index
  end
end

get "/urls/:id" do |id|
  @url = Url.find(id)
  erb :"urls/show"
end

get '/:short_url' do |short_url|
  # redirect to appropriate "long" URL
  @url = Url.find_by_short_url(short_url)
  @url.increment!(:click_count, by = 1)
  redirect "#{@url.full_url}"
end
