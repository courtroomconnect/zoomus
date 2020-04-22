# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Account do
  let(:zc) { zoom_client }
  let(:args) {
    {
      first_name: 'some',
      last_name: 'person',
      email: 'some@person.com',
      password: '12345678910!@#$%^&*()',
    }
  }
  let(:response) { zc.account_create(args) }

  describe '#account_create action' do
    context 'with 200 response' do
      before :each do
        stub_request(
          :post,
          zoom_url("/accounts")
        ).to_return(status: 201,
                    body: json_response('account', 'create'),
                    headers: { 'Content-Type' => 'application/json' })
      end

      it 'requires first_name param' do
        expect { zc.account_create(filter_key(args, :first_name)) }.to raise_error(Zoom::ParameterMissing, [:first_name].to_s)
      end

      it 'requires last_name param' do
        expect { zc.account_create(filter_key(args, :last_name)) }.to raise_error(Zoom::ParameterMissing, [:last_name].to_s)
      end

      it 'requires email param' do
        expect { zc.account_create(filter_key(args, :email)) }.to raise_error(Zoom::ParameterMissing, [:email].to_s)
      end

      it 'requires password param' do
        expect { zc.account_create(filter_key(args, :password)) }.to raise_error(Zoom::ParameterMissing, [:password].to_s)
      end

      it 'returns a hash' do
        expect(response).to be_kind_of(Hash)
      end
    end

    context 'with a 4xx response' do
      before :each do
        stub_request(
          :post,
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
