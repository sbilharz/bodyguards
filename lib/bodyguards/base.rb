require './rule_set'
require './rule'

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
    end
  end
end
