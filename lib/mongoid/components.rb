# encoding: utf-8
module Mongoid #:nodoc
  module Components #:nodoc
    extend ActiveSupport::Concern

    # All modules that a +Document+ is composed of are defined in this
    # module, to keep the document class from getting too cluttered.
    included do
      extend ActiveModel::Translation
      extend Mongoid::Finders

      class_attribute :paranoid
    end

    include ActiveModel::Conversion
    include ActiveModel::MassAssignmentSecurity
    include ActiveModel::Naming
    include ActiveModel::Observing
    include ActiveModel::Serializers::JSON
    include ActiveModel::Serializers::Xml
    include Mongoid::Atomic
    include Mongoid::Dirty
    include Mongoid::Attributes
    include Mongoid::Copyable
    include Mongoid::Fields
    include Mongoid::Hierarchy
    include Mongoid::Indexes
    include Mongoid::Inspection
    include Mongoid::JSON
    include Mongoid::Matchers
    include Mongoid::NestedAttributes
    include Mongoid::Persistence
    include Mongoid::Relations
    include Mongoid::Reloading
    include Mongoid::Safety
    include Mongoid::Scoping
    include Mongoid::Sessions
    include Mongoid::Serialization
    include Mongoid::Sharding
    include Mongoid::State
    include Mongoid::Threaded::Lifecycle
    include Mongoid::Timestamps::Timeless
    include Mongoid::Validations
    include Mongoid::Callbacks
    include Mongoid::MultiDatabase

    MODULES = [
      Mongoid::Atomic,
      Mongoid::Attributes,
      Mongoid::Copyable,
      Mongoid::Dirty,
      Mongoid::Fields,
      Mongoid::Hierarchy,
      Mongoid::Indexes,
      Mongoid::Inspection,
      Mongoid::JSON,
      Mongoid::Matchers,
      Mongoid::NestedAttributes,
      Mongoid::Persistence,
      Mongoid::Relations,
      Mongoid::Relations::Proxy,
      Mongoid::Safety,
      Mongoid::Scoping,
      Mongoid::Serialization,
      Mongoid::Sharding,
      Mongoid::State,
      Mongoid::Validations,
      Mongoid::Callbacks,
      Mongoid::MultiDatabase,
    ]

    class << self

      # Get a list of methods that would be a bad idea to define as field names
      # or override when including Mongoid::Document.
      #
      # @example Bad thing!
      #   Mongoid::Components.prohibited_methods
      #
      # @return [ Array<Symbol> ]
      #
      # @since 2.1.8
      def prohibited_methods
        @prohibited_methods ||= MODULES.inject([]) do |methods, mod|
          methods.tap do |mets|
            mets << mod.instance_methods.map{ |m| m.to_sym }
          end
        end.flatten
      end
    end
  end
end
