# frozen_string_literal: true

# Service to edit Internship post
class EditInternship
  class InternshipNotEdited < StandardError; end

  def initialize(config)
    @config = config
  end

  def api_url
    @config.API_URL
  end

  def call(current_account:, intern_id:)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                   .put("#{api_url}/internships/#{intern_id}")

    raise InternshipNotEdited unless response.code == 200
  end
end
