class TwitterAccountsController < ApplicationController
  def show
    headers['Access-Control-Allow-Origin'] = '*'
    render json: params
  end
end
