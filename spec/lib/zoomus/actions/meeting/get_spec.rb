require 'spec_helper'

describe Zoomus::Actions::Meeting do

  before :all do
    @zc = zoomus_client
    @args = {:host_id => "ufR9342pRyf8ePFN92dttQ", :id => 521910404}
  end

  describe "#meeting_get action" do
    before :each do
      stub_request(
          :post,
          zoomus_url("/meeting/get")
      ).to_return(:body => json_response("meeting_get"))
    end

    it "requires a 'host_id' argument" do
      expect{@zc.meeting_get}.to raise_error(ArgumentError)
    end

    it "returns a hash" do
      expect(@zc.meeting_get(@args)).to be_kind_of(Hash)
    end

    it "returns object host_id argument" do
      expect(@zc.meeting_get(@args)['host_id']).to match @args[:host_id]
    end
  end

  describe "#meeting_get! action" do
    before :each do
      stub_request(
          :post,
          zoomus_url("/meeting/get")
      ).to_return(:body => json_response("error"))
    end

    it "raises Zoomus::Error exception" do
      expect {
        @zc.meeting_get!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
