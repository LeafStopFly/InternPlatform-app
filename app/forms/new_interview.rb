# frozen_string_literal: true

require_relative 'form_base'

module ISSInternship
  module Form
    # New interview post
    class NewInterview < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_interview.yml')

      params do
        required(:position).filled(:string)
        required(:rating).filled(:float)
        required(:iss_module).maybe(:string)
        required(:time).filled(:string)
        required(:interview_location).filled(:string)
        required(:level).filled(:string)
        required(:recruit_source).maybe(:string)
        required(:result).filled(:string)
        required(:description).filled(:string)
        required(:waiting_result_time).maybe(:string)
        required(:advice).maybe(:string)
        required(:company_name).maybe(:string)
        required(:non_anonymous).filled
      end
    end
  end
end
