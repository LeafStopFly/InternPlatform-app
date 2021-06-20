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
      # process_relationships(intern_info['relationships'])
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

    # def process_relationships(relationships)
    #   return unless relationships

    #   @owner = Account.new(relationships['owner'])
    #   @collaborators = process_collaborators(relationships['collaborators'])
    #   @documents = process_documents(relationships['documents'])
    # end

    def process_policies(policies)
      @policies = OpenStruct.new(policies)
    end

    # def process_documents(documents_info)
    #   return nil unless documents_info

    #   documents_info.map { |doc_info| Document.new(doc_info) }
    # end

    # def process_collaborators(collaborators)
    #   return nil unless collaborators

    #   collaborators.map { |account_info| Account.new(account_info) }
    # end
  end
end
