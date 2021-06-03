require 'roda'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('companies') do |routing|
      routing.on do
        # GET /companies/
        routing.get do
          if @current_account.logged_in?
            project_list = GetAllCompanies.new(App.config).call(@current_account)

            companies = Companies.new(company_list)

            view :projects_all,
                 locals: { current_user: @current_account, companies: companies }
          else
            routing.redirect '/auth/login'
          end
        end
      end
    end
  end
end