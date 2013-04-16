get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/tweet' do
  puts params
  sleep 2
  Twitter.update(params[:tweet])
  200
  #erb :index
end
