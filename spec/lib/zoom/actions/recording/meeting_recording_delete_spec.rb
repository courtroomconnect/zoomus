# frozen_string_literal: true

require 'spec_helper'

describe Zoom::Actions::Recording do

  before :all do
    @zc = zoom_client
    @args = { meeting_id: 'ucc69C82Q5mTNyCRWE29Aw==', recording_id: "abc123" }
  end

  describe '#recording_delete action' do
    before :each do
      stub_request(
          :delete,
          zoom_url("/meetings/#{@args[:meeting_id]}/recordings/#{@args[:recording_id]}")
      ).to_return(body: {status: 204}.to_json)
    end

    it "requires a 'meeting_id' argument" do
      expect {
        @zc.meeting_recording_delete(filter_key(@args, :meeting_id))
      }.to raise_error(Zoom::ParameterMissing)
    end

    it "requires a 'recording_id' argument" do
      expect {
        @zc.meeting_recording_delete(filter_key(@args, :recording_id))
      }.to raise_error(Zoom::ParameterMissing)
    end

  end

end
