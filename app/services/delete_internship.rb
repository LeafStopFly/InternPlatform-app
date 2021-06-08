# frozen_string_literal: true

# Service to add collaborator to project
class DeleteInternship
  class InternshipNotDeleted < StandardError; end
  def initialize(config)
    @config = config
  end

  def api_url
    @config.API_URL
  end

  def call(current_account:, intern_id:)
    response = HTTP.auth("Bearer #{current_account.auth_token}")
                    .delete("#{api_url}/internships/#{intern_id}")

    raise InternshipNotDeleted unless response.code == 200
  end
end