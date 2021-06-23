# frozen_string_literal: true

require_relative 'form_base'

module ISSInternship
  module Form
    # New company
    class NewCompany < Dry::Validation::Contract
      config.messages.load_paths << File.join(__dir__, 'errors/new_company.yml')

      params do
        required(:company_no).maybe(format?: COMPNUM_REGEX)
      end
    end
  end
end
