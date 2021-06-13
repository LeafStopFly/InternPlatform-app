# frozen_string_literal: true

require_relative 'company'

module ISSInternship
  # Behaviors of the currently logged in account
  class Company
    attr_reader :id, :company_no, :name, :address # basic info

    def initialize(comp_info)
      process_attributes(comp_info['attributes'])
      # process_relationships(comp_info['relationships'])
      process_policies(comp_info['policies'])
    end

    private

    def process_attributes(attributes)
      @id = attributes['id']
      @company_no = attributes['company_no']
      @name = attributes['name']
      @address = attributes['address']
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
