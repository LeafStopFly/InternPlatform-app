# frozen_string_literal: true

require_relative 'form_base'

module ISSInternship
  module Form
    # New interview post
    class NewInterview < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_interview.yml')

      params do
        required(:position).filled(:string)
        required(:rating).filled(:string)
        required(:iss_module).maybe(:string)
      end
    end
  end
end
