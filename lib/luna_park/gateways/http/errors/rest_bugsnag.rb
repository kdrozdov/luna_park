# frozen_string_literal: true

module LunaPark
  module Gateways
    module Http
      module Errors
        module RestBugsnag
          class Diagnostic < RestClient::Exception
            include Bugsnag::MetaData

            attr_reader :title, :request, :response

            def initialize(title, request:, response:) # rubocop:disable Metrics/MethodLength
              super(response)
              @title   = title
              @request = request

              self.bugsnag_meta_data = {
                title: title,
                client_request: {
                  url: request.url,
                  method: request.method,
                  headers: request.headers,
                  body: try_parse(request.body)
                },
                client_response: {
                  code: response&.code,
                  headers: response&.headers,
                  body: try_parse(response&.message)
                }
              }
            end

            private

            def try_parse(string)
              JSON.parse(string) if string
            rescue JSON::ParserError
              string
            end
          end

          class Timeout < RestClient::Exceptions::Timeout
            include Bugsnag::MetaData

            attr_reader :title, :request

            def initialize(title, request:) # rubocop:disable Metrics/MethodLength
              super
              @title   = title
              @request = request

              self.bugsnag_meta_data = {
                title: title,
                client_request: {
                  url: request.url,
                  method: request.method,
                  headers: request.headers,
                  body: try_parse(request.body)
                }
              }
            end

            private

            def try_parse(string)
              JSON.parse(string) if string
            rescue JSON::ParserError
              string
            end
          end
        end
      end
    end
  end
end
