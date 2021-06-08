# frozen_string_literal: true

require 'http'

# Create a new company for a company
class CreateNewCompany
  def initialize(config)
    @config = config
  end

  def api_url
    @config.API_URL
  end

  def call(current_account:, company_data:)
    config_url = "#{api_url}/companies"
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .post(config_url, json: company_data)

    response.code == 201 ? JSON.parse(response.body.to_s) : raise
  end
end
