class TwitterAccountsController < ApplicationController
  before_action :do_cors

  FLAGGED = []

  def show
    if subject.populated_at
      subject.friends.map do |friend|
        if FLAGGED.include? friend.screen_name
          render json: friend
        else
          friend.friends.map do |superfriend|
            if FLAGGED.include? friend.screen_name
              render json: friend
            end
          end
        end
      end
    else
      collect_friends(subject)
    end
  end

  def collect_friends(subject)
    get_friends(subject)

    subject.friends.each do |friend|
      get_friends(friend)
    end
  end

  def do_cors
    headers['Access-Control-Allow-Origin'] = '*'
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
