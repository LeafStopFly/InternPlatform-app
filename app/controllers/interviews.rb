# frozen_string_literal: true

require 'roda'
require_relative './app'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('interviews') do |routing|
      routing.on do
        @interviews_route = '/interviews'

        routing.on(String) do |interv_id|
          @interview_route = "#{@interviews_route}/#{interv_id}"

          routing.on 'edit' do
            # GET /interviews/[interv_id]/edit
            routing.get do
              
              interv_info = GetInterview.new(App.config).call(
                @current_account, interv_id
              )
              interv = Interview.new(interv_info)

              view :edit_interview, locals: {
                current_account: @current_account, interview: interv
              }
            rescue StandardError => e
              puts "#{e.inspect}\n#{e.backtrace}"
              flash[:error] = 'Interview not found'
              routing.redirect @interviews_route
            end
          end
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

          # POST /interviews/[interv_id]
          routing.post do
            action = routing.params['action']

            task_list = {
              'edit' => { service: EditInterview,
                          message: 'Edited the interview.' },
              'delete' => { service: DeleteInterview,
                            message: 'Deleted the interview.' }
            }

            routing.params['level']=routing.params['rating-star']
            routing.params['rating']=routing.params['rating2-star'].to_f
            new_data = Form::NewInterview.new.call(routing.params)
            if new_data.failure?
              flash[:error] = Form.message_values(new_data)
              routing.halt
            end
            task = task_list[action]
            task[:service].new(App.config).call(
              current_account: @current_account,
              interv_id: interv_id,
              interview_data: new_data.to_h
            )
            flash[:notice] = task[:message]

          rescue StandardError
            flash[:error] = 'Could not update interview post'
          ensure
            routing.redirect @interviews_route
          end
        end

        # GET /interviews/
        routing.get do
          interview_list = GetAllInterviews.new(App.config).call(@current_account)

          interviews = Interviews.new(interview_list)

          view :interview_sharing, locals: {
            current_user: @current_account, interviews: interviews
          }
        end

        # POST /interviews/
        routing.post do
          routing.redirect '/auth/login' unless @current_account.logged_in?

          routing.params['level']=routing.params['rating-star']
          routing.params['rating']=routing.params['rating2-star'].to_f
          interview_data = Form::NewInterview.new.call(routing.params)
          if interview_data.failure?
            flash[:error] = Form.message_values(interview_data)
            routing.halt
          end
          CreateNewInterview.new(App.config).call(
            current_account: @current_account,
            interview_data: interview_data.to_h
          )

          flash[:notice] = "Add Interview Sharing! #{interview_data[:position]}"
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
