# frozen_string_literal: true

module Zoom
  module Actions
    module Recording

      #https://marketplace.zoom.us/docs/api-reference/zoom-api/cloud-recording/recordingget
      # Note: meeting_id can be pmi or a meetingId
      def meeting_recording_list(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:meeting_id)
        Utils.parse_response self.class.get("/meetings/#{options[:meeting_id]}/recordings", headers: request_headers)
      end

      def meeting_recording_delete(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:meeting_id, :recording_id)
        Utils.parse_response self.class.delete("/meetings/#{options[:meeting_id]}/recordings/#{options[:recording_id]}", query: options)
      end
    end
  end
end
