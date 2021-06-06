# frozen_string_literal: true

require_relative 'interview'

module ISSInternship
  # Behaviors of the currently logged in account
  class Interviews
    attr_reader :all

    def initialize(interviews_list)
      @all = interviews_list.map do |interv|
        Interview.new(interv)
      end
    end
  end
end
