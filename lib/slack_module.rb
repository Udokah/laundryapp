module Slack_module

  class Slack
    require 'uri'
    require 'open-uri'

    CLIENT_ID = "2853699384.6656542565"
    CLIENT_SECRET = "af815ec827e76c467c752eb6b15ce6e0"
    CLIENT_TEAM = "Andela"
    URL = Hash[ "oauth_access" => "https://slack.com/api/oauth.access",
                "authorize"    => "https://slack.com/oauth/authorize",
                "auth_test"    => "https://slack.com/api/auth.test",
                "users_info"   => "https://slack.com/api/users.info" ]

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
    def get_user_info(access_token)
      uri = URI.parse(URL["auth_test"])
      params = { :token => access_token }
      uri.query = URI.encode_www_form( params )
      return JSON.parse( uri.open.read )
    end

  end

end