# frozen_string_literal: true

require 'http'

# Returns all interviews belonging to an account
class GetOwnInterviews
  def initialize(config)
    @config = config
  end

  def call(current_account)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .get("#{@config.API_URL}/interviews")

    response.code == 200 ? JSON.parse(response.to_s)['data'] : nil
  end
end
