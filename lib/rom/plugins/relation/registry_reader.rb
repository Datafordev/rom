module ROM
  module Plugins
    module Relation
      EMPTY_REGISTRY = RelationRegistry.new.freeze

      # Allows relations to access all other relations through registry
      #
      # For now this plugin is always enabled
      #
      # @api public
      module RegistryReader
        # @api private
        def self.included(klass)
          super
          klass.option :__registry__, type: RelationRegistry, default: EMPTY_REGISTRY, reader: true
        end

        # @api private
        def respond_to_missing?(name, _include_private = false)
          __registry__.key?(name) || super
        end

        private

        # @api private
        def method_missing(name, *)
          __registry__.fetch(name) { super }
        end
      end
    end
  end
end
