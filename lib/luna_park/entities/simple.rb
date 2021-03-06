# frozen_string_literal: true

require 'luna_park/extensions/wrappable'
require 'luna_park/extensions/attributable'
require 'luna_park/errors'

module LunaPark
  module Entities
    # add description
    class Simple
      extend  Extensions::Wrappable
      include Extensions::Attributable

      def initialize(attrs = {})
        set_attributes(attrs)
      end

      def eql?(other)
        other.is_a?(self.class) && self == other
      end

      # @abstract
      def ==(_other)
        raise Errors::AbstractMethod
      end

      def serialize
        to_h
      end

      # @abstract
      def to_h
        raise Errors::AbstractMethod
      end

      public :set_attributes
    end
  end
end
