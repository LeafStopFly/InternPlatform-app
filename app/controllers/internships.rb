# frozen_string_literal: true

require 'roda'
require_relative './app'

module ISSInternship
  # Web controller for ISSInternship API
  class App < Roda
    route('internships') do |routing|
      routing.on do
        @internships_route = '/internships'

        routing.on(String) do |intern_id|
          @internship_route = "#{@internships_route}/#{intern_id}"

          routing.on 'edit' do
            # GET /internships/[intern_id]/edit
            routing.get do
              intern_info = GetInternship.new(App.config).call(
                @current_account, intern_id
              )
              intern = Internship.new(intern_info)

              view :edit_internship, locals: {
                current_account: @current_account, internship: intern
              }
            rescue StandardError => e
              puts "#{e.inspect}\n#{e.backtrace}"
              flash[:error] = 'Internship not found'
              routing.redirect @internships_route
            end
          end

          routing.on 'delete' do
            # POST /internships/[intern_id]/delete
            routing.post do
              DeleteInternship.new(App.config).call(
                current_account: @current_account,
                intern_id: intern_id
              )

              flash[:notice] = 'Deleted the internship.'
            rescue StandardError
              flash[:error] = 'Could not delete internship post'
            ensure
              routing.redirect '/mypost'
            end
          end
          # GET /internships/[intern_id]
          routing.get do
            intern_info = GetInternship.new(App.config).call(
              @current_account, intern_id
            )
            internship = Internship.new(intern_info)

            view :internship_single, locals: {
              current_account: @current_account, internship: internship
            }
          rescue StandardError => e
            puts "#{e.inspect}\n#{e.backtrace}"
            flash[:error] = 'Internship not found'
            routing.redirect @internships_route
          end

          # Edit
          # POST /internships/[intern_id]
          routing.post do
            routing.params['rating'] = routing.params['rating-star'].to_f

            new_data = Form::NewInternship.new.call(routing.params)
            if new_data.failure?
              flash[:error] = Form.message_values(new_data)
              routing.halt
            end
            EditInternship.new(App.config).call(
              current_account: @current_account,
              intern_id: intern_id,
              internship_data: new_data.to_h
            )

            flash[:notice] = 'Edited the internship.'
          rescue StandardError
            flash[:error] = 'Could not update internship post'
          ensure
            routing.redirect @internship_route
          end
        end

        # GET /internships/
        routing.get do

          iss_m= routing.params['iss_module']
          internship_list = 
            if iss_m.nil? || iss_m == ""
              iss_m=""
              GetAllInternships.new(App.config).call
            else
              interns = GetAllInternships.new(App.config).call_issmodule(iss_m)
              iss_m=ISSModule.transform(iss_m)
              interns
            end
          internships = Internships.new(internship_list)
          view :internship_sharing, locals: {
            current_user: @current_account, internships: internships, iss_m: iss_m
          }
        end

        # POST /internships/
        routing.post do
          routing.params['rating'] = routing.params['rating-star'].to_f

          internship_data = Form::NewInternship.new.call(routing.params)
          if internship_data.failure?
            flash[:error] = Form.message_values(internship_data)
            routing.halt
          end

          CreateNewInternship.new(App.config).call(
            current_account: @current_account,
            internship_data: internship_data.to_h
          )

          flash[:notice] = "Add Internship Sharing! #{internship_data[:title]}"
        rescue StandardError => e
          puts "FAILURE Creating Internship: #{e.inspect}"
          flash[:error] = 'Could not create internship'
        ensure
          routing.redirect '/mypost'
        end
      end
    end
  end
end
