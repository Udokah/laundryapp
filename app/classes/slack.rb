class Slack
  require 'uri'
  require 'open-uri'

  CLIENT_ID     = "2853699384.6656542565"
  CLIENT_SECRET = "af815ec827e76c467c752eb6b15ce6e0"
  CLIENT_TEAM   = "T02R3LKBA"
  CLIENT_SCOPE  = 'identify'
  URL           = Hash[ "oauth_access" => "https://slack.com/api/oauth.access",
                        "authorize"    => "https://slack.com/oauth/authorize",
                        "auth_test"    => "https://slack.com/api/auth.test",
                        "user_info"    => "https://slack.com/api/users.info",
                        "im_open"      => "https://slack.com/api/im.open",
                        "im_close"     => "https://slack.com/api/im.close",
                        "post_msg"     => "https://slack.com/api/chat.postMessage" ]
  BOT_TOKEN     = "xoxb-7148934290-kxwGuq6ZIsRwHQ3QU3eOgOkf"
  BOT_USERNAME  = "laundryappbot"

  # Send DM to user
  def send_dm(current_user , next_user)
    text_to_send = generate_message(current_user[:id], next_user.slack_id)
    open_channel = open_im_channel(BOT_TOKEN, next_user.slack_id)
    if open_channel["ok"] then
      post_msg = post_message(BOT_TOKEN, open_channel["channel"]["id"], text_to_send, BOT_USERNAME)
      if post_msg["ok"] then
        close_channel = close_im_channel(BOT_TOKEN, open_channel["channel"]["id"])
        return close_channel
      end
    end
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

  #########   Private Methods here #####

  # Open new IM channel
  private
  def open_im_channel(token, user)
    uri = URI.parse(URL["im_open"])
    params = { :token => token, :user => user }
    uri.query = URI.encode_www_form( params )
    return JSON.parse( uri.open.read )
  end

  def close_im_channel(token, channel)
    uri = URI.parse(URL["im_close"])
    params = { :token => token, :channel => channel }
    uri.query = URI.encode_www_form( params )
    return JSON.parse( uri.open.read )
  end

  # Post message to a channel
  def post_message(token, channel, text, username)
    uri = URI.parse(URL["post_msg"])
    params = { :token    => token,
               :channel  => channel,
               :text     => text,
               :username => username,
               :as_user  => true }
    uri.query = URI.encode_www_form( params )
    return JSON.parse( uri.open.read )
  end

  # generate messge to send to user
  def generate_message(prev_user, next_user)
    text = "<@#{next_user}> you can now use the laundry machine <@#{prev_user}> is done using it."
    return text
  end

end