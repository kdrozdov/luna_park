# frozen_string_literal: true

require 'luna_park/errors'

module LunaPark
  module Values
    class Single
      def self.wrap(input)
        return input if input.is_a?(self)

        raise Errors::Unwrapable, "#{self} can not wrap #{input.class}"
      end

      def initialize(value)
        @value = value
      end

      def ==(other)
        value == other.value
      end

      def serialize
        value
      end

      def inspect
        "#<#{self.class} #{value.inspect}>"
      end

      protected

      attr_reader :value
    end
  end
end
