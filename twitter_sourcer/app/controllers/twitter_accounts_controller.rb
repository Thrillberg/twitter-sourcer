class TwitterAccountsController < ApplicationController
  def show
    headers['Access-Control-Allow-Origin'] = '*'

    get_friends(subject)

    everyone = subject.friends.each do |friend|
      get_friends(friend)
    end

    render json: everyone
  end

  private

  def subject
    get_twitter_account || create_account_from(params: params)
  end

  def get_twitter_account
    TwitterAccount.find_by_screen_name(params[:twitter_account])
  end

  def create_account_from(params:)
    create_account(
      TwitterInterface.get_user(params[:twitter_account]),
      follower: nil,
    )
  end

  def create_account(account, follower:)
    TwitterAccount.create(
      twitter_id: account.id,
      name: account.name,
      screen_name: account.screen_name,
      friends_count: account.friends_count,
      follower: follower,
    )
  end

  def get_friends(twitter_account)
    unless twitter_account.populated_at
      screen_name = twitter_account.screen_name
      friends = TwitterInterface.friends(screen_name)
      friends.map do |friend|
        TwitterAccount.find_by_twitter_id(friend.id) ||
          create_account(
            friend,
            follower: twitter_account,
          )
      end
      twitter_account.update(populated_at: Time.now)
    end
  end
end
