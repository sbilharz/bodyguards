require 'active_support/core_ext/class/attribute'
require 'active_support/core_ext/string/inflections'
require_relative 'rule_set'
require_relative 'rule'
require_relative 'default_permission_evaluation_context'

module Bodyguards
  class Base
    class_attribute :permission_evaluation_context_class_name, instance_writer: false, instance_reader: false, default: 'Bodyguards::DefaultPermissionEvaluationContext'

    class << self
      def rule_set
        @rule_set ||= RuleSet.new
      end

      def permission_evaluation_context(*args)
        permission_evaluation_context_class_name.constantize.new(*args)
      end

      def permit_to(feature_name, &block)
        rule_set.add_rule_for(feature_name, Rule.new(evaluator: block))
      end

      def permit_all(&block)
        rule_set.add_global_rule(Rule.new(evaluator: block))
      end

      def permission_to?(feature_name, *args)
        rule_set.evaluate(feature_name, permission_evaluation_context(*args))
      end

      def rejection_to?(feature_name, *args)
        !permission_to?(feature_name, permission_evaluation_context(*args))
      end

      def any_permission?(*args)
        rule_set.evaluate_all(permission_evaluation_context(*args))
      end
    end
  end
end
