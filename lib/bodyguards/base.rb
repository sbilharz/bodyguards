require_relative 'rule_set'
require_relative 'rule'

module Bodyguards
  class Base
    class << self
      def rule_set
        @rule_set ||= RuleSet.new
      end

      def permit_to(feature_name, &block)
        rule_set.add_rule_for(feature_name, Rule.new(evaluator: block))
      end

      def permission_to?(feature_name, subject)
        rule_set.evaluate(feature_name, subject)
      end

      def rejection_to?(feature_name, subject)
        !permission_to?(feature_name, subject)
      end

      def any_permission?(subject)
        rule_set.evaluate_all(subject)
      end
    end
  end
end
