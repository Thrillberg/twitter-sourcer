Rails.application.routes.draw do
  get "/:twitter_account", to: "twitter_accounts#show"
end
