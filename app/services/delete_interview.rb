# frozen_string_literal: true

# Service to delete Internview post
class DeleteInterview
  class InterviewNotDeleted < StandardError; end

  def initialize(config)
    @config = config
  end

  def api_url
    @config.API_URL
  end

  def call(current_account:, interv_id:)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .delete("#{api_url}/interviews/#{interv_id}")

    raise InterviewNotDeleted unless response.code == 200
  end
end
