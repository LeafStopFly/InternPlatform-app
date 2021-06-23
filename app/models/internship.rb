# frozen_string_literal: true

require_relative 'internship'

module ISSInternship
  # Behaviors of the currently logged in account
  class Internship
    attr_reader :id, :title, :position, :rating, :iss_module, # basic info
                :year, :period, :job_description, :salary, :reactionary, :recruit_source,
                :company_name, :non_anonymous, :author # full details

    def initialize(intern_info)
      process_attributes(intern_info['attributes'])
      process_policies(intern_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @title = attributes['title']
      @position = attributes['position']
      @rating = attributes['rating']
      @iss_module = attributes['iss_module']
      @year = attributes['year']
      @period = attributes['period']
      @job_description = attributes['job_description']
      @salary = attributes['salary']
      @reactionary = attributes['reactionary']
      @recruit_source = attributes['recruit_source']
      @company_name = attributes['company_name']
      @non_anonymous = attributes['non_anonymous']
      @author = attributes['author']
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end
  end
end
