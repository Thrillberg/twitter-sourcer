# Twitter Sourcer

This project is intended to be a browser extension that tells Twitter users
what, if any, detectable biases might exist on the part of tweet authors that
they read in their feed. The extension will be fed results from a call to a
Rails back-end server, which will call upon the Twitter API for information
about users.

## Plan

This is very flexible but represents my current thinking:

~~- Make basic extension~~

~~- Make basic server and connect it to extension~~

- Identify touchstones of political ideology
  (A touchstone is a Twitter account that skews very highly in favor of the
ideology, the more popular the account, the better.)
  - What ideologies do we want to cover?
    - Racism / White nationalism
    - Misogyny
    - Anti-Jewishness
    - Anti-Islam
    - Anti-Christianity
    - Identity politics
    - Capitalism
    - Fascism
    - Communism
    - Climate change denial
  - How do we identify the touchstones?
    - We want to be as uncontroversial as possible while still revealing more
      than simply if someone is "left-wing" or "right-wing".
    - Do people self-identify with the above ideologies? Start here.
- Call Twitter API on each touchstone to gather their followers.
  - Consider implications of overlap (followers who follow two different
    touchstones for two different ideologies).
  - Store followers in Rails db (figure out the schema).
  - Repeat for followers of followers of touchstones, perhaps with a
    qualification that the follower must follow at least 3 touchstones for a
    given ideology.
- Whenever the extension requests from the server with a Twitter user name,
  first look in the db to see if they are in any way connected to a touchstone.
  - If so, present a message: "Thrillberg might be sympathetic to identity
    politics.", or something like that.
  - If not, figure out how to find the degrees of separation from a touchstone.
- I think if our db can gradually increase in size, then we'll avoid Twitter's
  extreme rate-limiting policy.
