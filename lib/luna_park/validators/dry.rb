# frozen_string_literal: true

require 'dry-validation'

module LunaPark
  module Validators
    class Dry
      def initialize(params)
        @params = params
      end

      def success?
        result.success?
      end

      def valid_params
        (success? && result.to_h) || {}
      end

      def errors
        result.errors.to_h || {}
      end

      private

      attr_reader :params

      def result
        @result ||= self.class.schema.call(params)
      end

      class << self
        def schema
          @_schema
        end

        alias validate new

        def validation_schema(&block)
          @_schema = Class.new(::Dry::Validation::Contract, &block).new
        end
      end
    end
  end
end
