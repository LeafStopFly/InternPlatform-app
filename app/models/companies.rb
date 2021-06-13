# frozen_string_literal: true

require_relative 'company'

module ISSInternship
  # Behaviors of the currently logged in account
  class Companies
    attr_reader :all

    def initialize(companies_list)
      @all = companies_list.map do |comp|
        Company.new(comp)
      end
    end
  end
end
