# frozen_string_literal: true

require 'http'

# Returns all internviews belonging to an account
class GetInterview
  def initialize(config)
    @config = config
  end

  def call(_current_account, interv_id)
    response = HTTP.get("#{@config.API_URL}/interviews/#{interv_id}")

    response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
  end
end
