# frozen_string_literal: true

module Zoom
  module Actions
    module Recording

      # https://marketplace.zoom.us/docs/api-reference/zoom-api/cloud-recording/recordingslist
      def meeting_recording_list(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:user_id).permit(:page_size, :next_page_token, :mc, :trash, :to, :from, :trash_type)
        Utils.parse_response self.class.get("/users/#{params[:user_id]}/recordings", query: params.except(:user_id), headers: request_headers)
      end

      # https://marketplace.zoom.us/docs/api-reference/zoom-api/cloud-recording/recordingget
      def meeting_recording_get(*args)
        params = Zoom::Params.new(Utils.extract_options!(args))
        params.require(:meeting_id)
        Utils.parse_response self.class.get("/meetings/#{params[:meeting_id]}/recordings", headers: request_headers)
      end

      def meeting_recording_delete(*args)
        options = Utils.extract_options!(args)
        Zoom::Params.new(options).require(:meeting_id, :recording_id)
        Utils.parse_response self.class.delete("/meetings/#{options[:meeting_id]}/recordings/#{options[:recording_id]}", query: options)
      end
    end
  end
end
