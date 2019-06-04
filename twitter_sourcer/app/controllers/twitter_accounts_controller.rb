class TwitterAccountsController < ApplicationController
  def show
    headers['Access-Control-Allow-Origin'] = '*'
    render json: {screen_name: params[:twitter_account]}.to_json
  end
end
