# frozen_string_literal: true

require 'roda'
require_relative './app'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('share') do |routing|
      # GET /share/internship
      routing.get('internship') do
        # company_list = GetAllCompanies.new(App.config).call

        # companies = Companies.new(company_list)

        view :internship_post, locals: {
          current_user: @current_account
        }
      end

      # GET /share/interview
      routing.get('interview') do
        # company_list = GetAllCompanies.new(App.config).call

        # companies = Companies.new(company_list)

        view :interview_post, locals: {
          current_user: @current_account
        }
      end
    end
  end
end
