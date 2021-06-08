# frozen_string_literal: true

require 'http'

# Returns all internships belonging to an account
class GetInternship
  def initialize(config)
    @config = config
  end

  def call(current_account, intern_id)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .get("#{@config.API_URL}/internships/#{intern_id}")

    response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
  end
end