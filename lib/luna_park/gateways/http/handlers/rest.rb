# frozen_string_literal: true

module LunaPark
  module Gateways
    module Http
      module Handlers
        class Rest
          attr_reader :skip_errors

          def initialize(skip_errors: [])
            @skip_errors = skip_errors
          end

          def error(title, request:, response:)
            unless skip_errors.include? response.code # rubocop:disable Style/GuardClause
              raise Errors::Rest::Diagnostic.new(title, request: request, response: response)
            end
          end

          def timeout_error(title, request:)
            raise Errors::Rest::Timeout.new(title, request: request) unless skip_errors.include?(:timeout)
          end
        end
      end
    end
  end
end
