# frozen_string_literal: true

require 'http'

# Returns all interviews
class GetAllInterviews
  def initialize(config)
    @config = config
  end

  def call(current_account)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .get("#{@config.API_URL}/all_interviews")

    response.code == 200 ? JSON.parse(response.to_s)['data'] : nil
  end
end
