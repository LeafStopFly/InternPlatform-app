# frozen_string_literal: true

require 'roda'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('interviews') do |routing|
      routing.on do
        routing.redirect '/auth/login' unless @current_account.logged_in?
        @interviews_route = '/interviews'

        routing.on(String) do |interv_id|
          @interview_route = "#{@interviews_route}/#{interv_id}"

          # GET /interviews/[interv_id]
          routing.get do
            interv_info = GetInterview.new(App.config).call(
              @current_account, interv_id
            )
            interview = Interview.new(interv_info)

            view :interview, locals: {
              current_account: @current_account, interview: interview
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Interview not found'
            routing.redirect @interviews_route
          end
        end

        # GET /interviews/
        routing.get do
          interview_list = GetAllInterviews.new(App.config).call(@current_account)

          interviews = Interviews.new(interview_list)

          view :interviews_all, locals: {
            current_user: @current_account, interviews: interviews
          }
        end

        # POST /interviews/
        routing.post do
          routing.redirect '/auth/login' unless @current_account.logged_in?
          puts "INTERV: #{routing.params}"
          interview_data = Form::NewInterview.new.call(routing.params)
          if interview_data.failure?
            flash[:error] = Form.message_values(interview_data)
            routing.halt
          end

          CreateNewInterciew.new(App.config).call(
            current_account: @current_account,
            interview_data: interview_data.to_h
          )

          # flash[:notice] = 'Add documents and collaborators to your new project'
        rescue StandardError => e
          puts "FAILURE Creating Interview: #{e.inspect}"
          flash[:error] = 'Could not create interview'
        ensure
          routing.redirect @interviews_route
        end
      end
    end
  end
end
