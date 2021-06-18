# frozen_string_literal: true

require 'roda'
require_relative './app'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('mypost') do |routing|
      routing.redirect '/auth/login' unless @current_account.logged_in?
      routing.on 'internships' do
        routing.on(String) do |intern_id|
          # GET /mypost/internships/[intern_id]
          routing.get do
            intern_info = GetInternship.new(App.config).call(
              @current_account, intern_id
            )
            internship = Internship.new(intern_info)

            view :my_internship, locals: {
              current_account: @current_account, internship: internship
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Internship not found'
            routing.redirect '/mypost/internships'
          end
        end
      end

      routing.on 'interviews' do
        routing.on(String) do |interv_id|
          # GET /mypost/interviews/[interv_id]
          routing.get do
            interv_info = GetInterview.new(App.config).call(
              @current_account, interv_id
            )
            interview = Interview.new(interv_info)

            view :my_interview, locals: {
              current_account: @current_account, interview: interview
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Interview not found'
            routing.redirect '/mypost/interviews'
          end
        end
      end

      # GET /mypost/
      routing.get do
        internship_list = GetOwnInternships.new(App.config).call(@current_account)
        internships = Internships.new(internship_list)

        interview_list = GetOwnInterviews.new(App.config).call(@current_account)
        interviews = Interviews.new(interview_list)

        view :mypost, locals: {
          current_user: @current_account, interviews: interviews, internships: internships
        }
      end
    end
  end
end
