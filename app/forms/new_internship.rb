# frozen_string_literal: true

require_relative 'form_base'

module ISSInternship
  module Form
    # New internship post
    class NewInternship < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_internship.yml')

      params do
        required(:title).filled(max_size?: 256, format?: TITLE_REGEX)
        required(:position).filled(:string)
        required(:rating).filled(:float)
        required(:iss_module).maybe(:string)
        required(:year).filled(:string)
        required(:period).filled(:string)
        required(:job_description).filled(:string)
        required(:salary).maybe(:string)
        required(:reactionary).filled(:string)
        required(:recruit_source).maybe(:string)
        required(:company_name).maybe(:string)
      end
    end
  end
end
