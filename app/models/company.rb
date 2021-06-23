# frozen_string_literal: true

require_relative 'company'

module ISSInternship
  # Behaviors of the currently logged in account
  class Company
    attr_reader :id, :company_no, :name, :address # basic info

    def initialize(comp_info)
      process_attributes(comp_info['attributes'])
      process_policies(comp_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @company_no = attributes['company_no']
      @name = attributes['name']
      @address = attributes['address']
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end
  end
end
