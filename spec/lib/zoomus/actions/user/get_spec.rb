require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
    @args = {:id => "ufR9342pRyf8ePFN92dttQ"}
  end

  describe "#user_get action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/get")
      ).to_return(:body => json_response("user_get"))
    end

    it "returns a hash" do
      expect(@zc.user_get(@args)).to be_kind_of(Hash)
    end

    it "requires a 'id' argument" do
      expect{@zc.user_get}.to raise_error(ArgumentError)
    end

    it "returns object id argument" do
      expect(@zc.user_get(@args)['id']).to match @args[:id]
    end
  end

  describe "#user_get! action" do
    before :each do
      stub_request(
        :post,
        zoomus_url("/user/get")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.user_get!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
