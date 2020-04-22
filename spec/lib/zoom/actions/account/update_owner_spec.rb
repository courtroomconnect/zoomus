# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Account do
  let(:zc) { zoom_client }
  let(:args) {
    {
      id: 'adfasdfaskdfjaskdfasdf',
      email: 'some@person.com',
    }
  }
  let(:response) { zc.account_update_owner(args) }

  describe '#account_update_owner action' do
    context 'with 200 response' do
      before :each do
        stub_request(
          :put,
          zoom_url("/accounts/#{args[:id]}/owner")
        ).to_return(status: 204,
                    body: '{ "code": 204, "message": "Account owner updated" }',
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'requires id param' do
        expect { zc.account_update_owner(filter_key(args, :id)) }.to raise_error(Zoom::ParameterMissing, [:id].to_s)
      end

      it 'requires email param' do
        expect { zc.account_update_owner(filter_key(args, :email)) }.to raise_error(Zoom::ParameterMissing, [:email].to_s)
      end
    end

    context 'with a 4xx response' do
      before :each do
        stub_request(
          :put,
          zoom_url("/accounts/#{args[:id]}/owner")
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
