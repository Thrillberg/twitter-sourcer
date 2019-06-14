require "rails_helper"

RSpec.describe TwitterAccountsController, "#show" do
  it "returns a TwitterAccount if it is a climate change denier" do
    account = create(:twitter_account)
    climate_change_denier = create(:twitter_account, :climate_change_denier)
    account.friends << climate_change_denier

    get :show, params: { twitter_account: account.screen_name }

    expect(response.body).to eq climate_change_denier.to_json
  end
end
