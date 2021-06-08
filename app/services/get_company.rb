# frozen_string_literal: true

require 'http'

# Returns all companies
class GetCompany
  def initialize(config)
    @config = config
  end

  def call(company_id)
    response = HTTP.get("#{@config.API_URL}/companies/#{company_id}")
    # response = HTTP.auth("Bearer #{current_account.auth_token}")
                  #  .get("#{@config.API_URL}/companies/#{company_id}")

    response.code == 200 ? JSON.parse(response.body.to_s)['data'] : nil
  end
end
