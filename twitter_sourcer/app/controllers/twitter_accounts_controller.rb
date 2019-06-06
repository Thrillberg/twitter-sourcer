class TwitterAccountsController < ApplicationController
  def show
    headers['Access-Control-Allow-Origin'] = '*'

    twitter_user = TwitterInterface.get_user(params[:twitter_account])

    # Me
    subject = TwitterAccount.find_by_twitter_id(twitter_user.id) ||
      create_account(twitter_user, follower: nil)

    # My friends
    friends = get_friends(subject)

    # My friends' friends
    everyone = friends.each do |friend|
      get_friends(friend)
    end

    render json: everyone
  end

  private

  def create_account(account, follower:)
    TwitterAccount.create(
      twitter_id: account.id,
      name: account.name,
      screen_name: account.screen_name,
      friends_count: account.friends_count,
      follower: follower,
    )
  end

  def get_friends(user)
    screen_name = user.screen_name
    friends = TwitterInterface.friends(screen_name)
    friends.map do |friend|
      TwitterAccount.find_by_twitter_id(friend.id) ||
        create_account(
          friend,
          follower: user,
        )
    end
  end
end
