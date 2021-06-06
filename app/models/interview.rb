# frozen_string_literal: true

require_relative 'interview'

module ISSInternship
  # Behaviors of the currently logged in account
  class Interview
    attr_reader :id, :position, :rating, :iss_module

    def initialize(interv_info)
      @id = interv_info['attributes']['id']
      @position = interv_info['attributes']['position']
      @rating = interv_info['attributes']['rating']
      @iss_module = interv_info['attributes']['iss_module']
    end
  end
end
