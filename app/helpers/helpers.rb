helpers do

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  def client
    @client = Twitter::Client.new(
      :oauth_token => current_user.token,
      :oauth_token_secret => current_user.secret
      )
  end

end
