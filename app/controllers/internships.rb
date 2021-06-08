# frozen_string_literal: true

require 'roda'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('internships') do |routing|
      routing.on do
        routing.redirect '/auth/login' unless @current_account.logged_in?
        @internships_route = '/internships'

        routing.on(String) do |intern_id|
          @internship_route = "#{@internships_route}/#{intern_id}"

          # GET /internships/[intern_id]
          routing.get do
            intern_info = GetInternship.new(App.config).call(
              @current_account, intern_id
            )
            internship = Internship.new(intern_info)

            view :internship, locals: {
              current_account: @current_account, internship: internship
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Internship not found'
            routing.redirect @internships_route
          end
        end

        # GET /internships/
        routing.get do
          internship_list = GetAllInternships.new(App.config).call(@current_account)

          internships = Internships.new(internship_list)

          view :internships_all, locals: {
            current_user: @current_account, internships: internships
          }
        end

        # POST /internships/
        routing.post do
          routing.redirect '/auth/login' unless @current_account.logged_in?
          puts "INTERN: #{routing.params}"
          internship_data = Form::NewInternship.new.call(routing.params)
          if internship_data.failure?
            flash[:error] = Form.message_values(internship_data)
            routing.halt
          end

          CreateNewInternship.new(App.config).call(
            current_account: @current_account,
            internship_data: internship_data.to_h
          )

          # flash[:notice] = 'Add documents and collaborators to your new project'
        rescue StandardError => e
          puts "FAILURE Creating Internship: #{e.inspect}"
          flash[:error] = 'Could not create internship'
        ensure
          routing.redirect @internships_route
        end
      end
    end
  end
end
