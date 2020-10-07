# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Recording do

  before :all do
    @zc = zoom_client
    @args = { user_id: "gkABCDEbbbbbbbkPuA==" }
  end

  describe '#recording_list action' do
    before :each do
      stub_request(
          :get,
          zoom_url("/users/#{@args[:user_id]}/recordings")
      ).to_return(body: json_response('recording', 'meeting_recording_list'))
    end

    it "requires a 'user_id' argument" do
      expect { @zc.recording_list }.to raise_error(Zoom::ParameterMissing)
    end

  end

end
