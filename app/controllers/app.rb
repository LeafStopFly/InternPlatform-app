# frozen_string_literal: true

require 'roda'
require 'slim'
require 'slim/include'

module ISSInternship
  # Base class for ISSInternship Web Application
  class App < Roda
    plugin :render, engine: 'slim', views: 'app/presentation/views'
    plugin :assets, css: 'style.css', path: 'app/presentation/assets'
    plugin :public, root: 'app/presentation/public'
    plugin :multi_route
    plugin :flash

    route do |routing|
      response['Content-Type'] = 'text/html; charset=utf-8'
      @current_account = CurrentSession.new(session).current_account

      routing.public
      routing.assets
      routing.multi_route

      # GET /
      routing.root do
        internship_list = GetAllInternships.new(App.config).call(@current_account)
        internships = Internships.new(internship_list)

        interview_list = GetAllInterviews.new(App.config).call(@current_account)
        interviews = Interviews.new(interview_list)
        
        view 'home', locals: {
          current_account: @current_account, interviews: interviews, internships: internships
        }
      end
    end
  end
end
