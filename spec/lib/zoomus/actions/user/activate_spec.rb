require 'spec_helper'

describe Zoomus::Actions::User do

  before :all do
    @zc = zoomus_client
    @args = {:id => '65q23kd9sqliy612h23k'}
  end

  describe '#user_activate action' do
    before :each do
      stub_request(
        :post,
        zoomus_url('/user/activate')
      ).to_return(:body => json_response('user_activate'))
    end

    it 'requires id param' do
      expect{@zc.user_activate(filter_key(@args, :id))}.to raise_error(ArgumentError)
    end

    it 'returns a hash' do
      expect(@zc.user_activate(@args)).to be_kind_of(Hash)
    end

    it 'returns the id and the activated_at' do
      res = @zc.user_activate(@args)

      expect(res['id']).to eq(@args[:id])
      expect(res['activated_at'].length).to be
    end
  end

  describe '#user_activate! action' do
    before :each do
      stub_request(
        :post,
        zoomus_url('/user/activate')
      ).to_return(:body => json_response('error'))
    end

    it 'raises Zoomus::Error exception' do
      expect {
        @zc.user_activate!(@args)
      }.to raise_error(Zoomus::Error)
    end
  end
end
