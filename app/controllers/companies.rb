# frozen_string_literal: true

require 'roda'
require_relative './app'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('companies') do |routing|
      routing.on do
        @companies_route = '/companies'

        routing.on(String) do |comp_id|
          @company_route = "#{@companies_route}/#{comp_id}"

          # GET /companies/[comp_id]
          routing.get do
            comp_info = GetCompany.new(App.config).call(comp_id)
            company = Company.new(comp_info)

            view :company, locals: {
              current_account: @current_account, company: company
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Company not found'
            routing.redirect @companies_route
          end
        end

        # GET /companies/
        routing.get do
          company_list = GetAllCompanies.new(App.config).call

          companies = Companies.new(company_list)

          view :companies_all, locals: {
            current_user: @current_account, companies: companies
          }
        end

        # POST /companies/
        routing.post do
          puts "COMP: #{routing.params}"
          company_data = Form::NewCompany.new.call(routing.params)
          if company_data.failure?
            flash[:error] = Form.message_values(company_data)
            routing.halt
          end

          company = CreateNewCompany.new(App.config).call(
            current_account: @current_account,
            company_data: company_data.to_h
          )

          company['data']['attributes']['name']
        rescue StandardError => e
          puts "FAILURE Creating Company: #{e.inspect}"
          flash[:error] = 'Could not create company'
        end
      end
    end
  end
end
