get '/' do
  erb :index
end

get '/oauth' do
  # 1- Check to see if the session has a user id
  # 2- If so, simply try to find the user for that user id
  # 3- Otherwise, authenticate via Twitter

  if session.has_key? :id
    @user = User.find(session[:id])
    session[:token] = @user.token
    session[:secret] = @user.secret
  else
    consumer = OAuth::Consumer.new(ENV['CONSUMER_KEY'],
                                   ENV['CONSUMER_SECRET'],
                                   :site => "https://api.twitter.com")

    session[:request_token] = consumer.get_request_token(:oauth_callback => "http://localhost:9393/auth")
    redirect session[:request_token].authorize_url
  end
  redirect '/'
end


get '/auth' do
  access_token = session[:request_token].get_access_token(:oauth_verifier => params[:oauth_verifier])
  
  session.delete(:request_token)
  user = User.find_or_create_by_twitter_id(access_token.params[:id])
  user.update_attributes(
    :token => access_token.token,
    :secret => access_token.secret
  )
  session[:id] = user.id

  user.update_attributes(:twitter_username => client.current_user.username,
                          :twitter_id => client.current_user.id)

  redirect '/'
end

get '/logout' do
  session.clear
  redirect '/'
end

# POSTING TWEETS
post '/tweet' do
  sleep 2
  client.update(params[:tweet])
  200
  #erb :index
end
