class TwitterAccountsController < ApplicationController
  before_action :do_cors

  def show
    subject.friends.map do |friend|
      if climate_change_deniers.include? friend
        render json: friend
      end
    end
  end

  def do_cors
    headers['Access-Control-Allow-Origin'] = '*'
  end

  private

  def subject
    get_twitter_account || create_account_from(params: params)
  end

  def climate_change_deniers
    TwitterAccount.includes(:political_positions).where(
      political_positions: { is_climate_change_denier: true },
    )
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
end
