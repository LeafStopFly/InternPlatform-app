# frozen_string_literal: true

require 'http'

# Returns all internships
class GetAllInternships
  def initialize(config)
    @config = config
  end

  def call
    response = HTTP.get("#{@config.API_URL}/all_internships")

    response.code == 200 ? JSON.parse(response.to_s)['data'] : nil
  end
end
