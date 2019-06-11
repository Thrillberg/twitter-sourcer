# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

climate_change_deniers = [
  "GOP",
  "HeartlandInst",
  "realDonaldTrump",
  "ClimateRealists",
  "BigJoeBastardi",
  "SkyNewsAust",
  "SteveSGoddard",
  "ClimateDepot",
  "JimInhofe",
  "Chris_C_Horner",
  "myronebell",
  "JunkScience",
  "CatoMichaels",
  "BjornLomborg",
  "mattwridley",
  "chris_monckton",
  "RoyWSpencer",
  "ukipmeps",
  "alexaguiarpoa",
  "APIenergy",
  "EELegal",
  "AEA",
  "IERenergy",
]

climate_change_deniers.each do |screen_name|
  return if TwitterAccount.find_by(screen_name: screen_name)

  account = TwitterInterface.get_user(screen_name)
  denier = TwitterAccount.create(
    twitter_id: account.id,
    name: account.name,
    screen_name: account.screen_name,
    friends_count: account.friends_count,
  )
  PoliticalPosition.create(
    is_climate_change_denier: true,
    twitter_account: denier,
  )
end
