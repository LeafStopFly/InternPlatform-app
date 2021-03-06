# frozen_string_literal: true

require_relative 'interview'

module ISSInternship
  # Behaviors of the currently logged in account
  class Interview
    attr_reader :id, :position, :rating, :iss_module, # basic info
                :time, :interview_location, :level, :recruit_source, :result, :description,
                :waiting_result_time, :advice, :company_name, :non_anonymous, :author # full details

    def initialize(interv_info)
      process_attributes(interv_info['attributes'])
      process_policies(interv_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @position = attributes['position']
      @rating = attributes['rating']
      @iss_module = attributes['iss_module']
      @time = attributes['time']
      @interview_location = attributes['interview_location']
      @level = attributes['level']
      @recruit_source = attributes['recruit_source']
      @result = attributes['result']
      @description = attributes['description']
      @waiting_result_time = attributes['waiting_result_time']
      @advice = attributes['advice']
      @company_name = attributes['company_name']
      @non_anonymous = attributes['non_anonymous']
      @author = attributes['author']
    end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end
  end
end
