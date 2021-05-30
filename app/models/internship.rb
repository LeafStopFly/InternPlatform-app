# frozen_string_literal: true

require_relative 'internship'

module ISSInternship
  # Behaviors of the currently logged in account
  class Internship
    attr_reader :id, :title, :position, :rating, :iss_module

    def initialize(intern_info)
      @id = intern_info['attributes']['id']
      @title = intern_info['attributes']['title']
      @position = intern_info['attributes']['position']
      @rating = intern_info['attributes']['rating']
      @iss_module = intern_info['attributes']['iss_module']
    end
  end
end
