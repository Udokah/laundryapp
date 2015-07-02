class Slack
  require 'uri'
  require 'open-uri'

  CLIENT_ID = "2853699384.6656542565"
  CLIENT_SECRET = "af815ec827e76c467c752eb6b15ce6e0"
  CLIENT_TEAM = "T02R3LKBA"
  CLIENT_SCOPE = 'read,identify,client,post'
  URL = Hash[ "oauth_access" => "https://slack.com/api/oauth.access",
              "authorize"    => "https://slack.com/oauth/authorize",
              "auth_test"    => "https://slack.com/api/auth.test",
              "user_info"    => "https://slack.com/api/users.info" ]

  # Send DM to user
  def send_slack_dm(user)
    
  end

  # generate authorizaton href
  def get_auth_href(state)
    uri = URI.parse(URL["authorize"])
    params = { :client_id => CLIENT_ID,
               :state     => state,
               :team      => CLIENT_TEAM,
               :scope     => CLIENT_SCOPE }
    uri.query = URI.encode_www_form( params )
    return uri
  end

  def get_user_info(token, user_id)
    uri = URI.parse(URL["user_info"])
    params = { :token => token, :user => user_id }
    uri.query = URI.encode_www_form( params )
    return JSON.parse( uri.open.read )
  end

  # Get the access token            
  def get_token(code)
    uri = URI.parse(URL["oauth_access"])
    params = { :client_id     => CLIENT_ID,
               :client_secret => CLIENT_SECRET,
               :code          => code
             }
  uri.query = URI.encode_www_form( params )
  return JSON.parse(uri.open.read)
  end

  # get users information
  def auth_user(access_token)
    uri = URI.parse(URL["auth_test"])
    params = { :token => access_token }
    uri.query = URI.encode_www_form( params )
    return JSON.parse( uri.open.read )
  end

end