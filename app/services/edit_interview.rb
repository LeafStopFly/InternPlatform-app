# frozen_string_literal: true

# Service to edit Interview post
class EditInterview
  class InterviewNotEdited < StandardError; end

  def initialize(config)
    @config = config
  end

  def api_url
    @config.API_URL
  end

  def call(current_account:, interv_id:, interview_data:)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .post("#{api_url}/interviews/#{interv_id}", json: interview_data)

    raise InterviewNotEdited unless response.code == 200
  end
end
