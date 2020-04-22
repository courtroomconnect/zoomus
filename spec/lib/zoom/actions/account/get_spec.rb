# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Account do
  let(:zc) { zoom_client }
  let(:args) { { id: 't13b6hjVQXybvGKyeHC96w==' } }
  let(:response) { zc.account_get(args) }

  describe '#account_get action' do
    context 'with 200 response' do
      before :each do
        stub_request(
          :get,
          zoom_url("/accounts/#{args[:id]}")
        ).to_return(body: json_response('account', 'get'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it "requires a 'id' argument" do
        expect { zc.account_get(filter_key(args, :id)) }.to raise_error(Zoom::ParameterMissing)
      end

      it 'returns a hash' do
        expect(response).to be_kind_of(Hash)
      end

      it 'raises an error when passed an invalid option' do
        expect { zc.account_list(foo: 'bar') }.to raise_error(Zoom::ParameterNotPermitted, [:foo].to_s)
      end
    end

    context 'with a 4xx response' do
      before :each do
        stub_request(
          :get,
          zoom_url('/accounts')
        ).to_return(status: 404,
                    body: json_response('error', 'not_found'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'raises Zoom::Error exception' do
        expect { response }.to raise_error(Zoom::Error)
      end
    end
  end
end
