# frozen_string_literal: true

require_relative 'internship'

module ISSInternship
  # Behaviors of the currently logged in account
  class Internships
    attr_reader :all

    def initialize(internships_list)
      @all = internships_list.map do |intern|
        Internship.new(intern)
      end
    end
  end
end
