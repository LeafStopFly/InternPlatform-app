# frozen_string_literal: true

require 'http'

# Returns all companines belonging to an account
class GetAllCompanies
  def initialize(config)
    @config = config
  end

  def call
    response = HTTP.get("#{@config.API_URL}/companies")

    response.code == 200 ? JSON.parse(response.to_s)['data'] : nil
  end
end
