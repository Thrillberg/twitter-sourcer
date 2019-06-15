class TwitterInterface
  def self.friends(screen_name)
    begin
      client.friends(
        screen_name,
        count: 200,
        skip_status: true,
        include_user_entities: false,
      )
    rescue Twitter::Error::TooManyRequests => error
      p "Too many requests!"
    end
  end

  def self.get_user(screen_name)
    client.user(screen_name)
  end

  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV.fetch("TWITTER_CONSUMER_API_KEY")
      config.consumer_secret = ENV.fetch("TWITTER_CONSUMER_API_SECRET_KEY")
      config.access_token = ENV.fetch("TWITTER_ACCESS_TOKEN")
      config.access_token_secret = ENV.fetch("TWITTER_ACCESS_TOKEN_SECRET")
    end
  end
end
