RSpec.describe TwitterInterface, ".friends" do
  it "calls client.friends" do
    client = double(friends: double)
    allow(Twitter::REST::Client).to receive(:new).and_return client

    TwitterInterface.friends("screen_name")

    expect(client).to have_received(:friends).with("screen_name", anything)
  end
end

RSpec.describe TwitterInterface, ".get_user" do
  it "calls client.user" do
    client = double(user: double)
    allow(Twitter::REST::Client).to receive(:new).and_return client

    TwitterInterface.get_user("screen_name")

    expect(client).to have_received(:user).with("screen_name")
  end
end
