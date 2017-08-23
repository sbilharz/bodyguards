module Bodyguards
  class RuleSet
    def initialize
      @global_rules = []
      @rules = {}
    end

    def add_rule_for(feature_name, rule)
      rules[feature_name.to_sym] = rule
    end

    def add_global_rule(rule)
      @global_rules << rule
    end

    def evaluate(feature_name, subject)
      return true if global_rules.any? { |rule| rule.evaluate(subject) }
      rules.fetch(feature_name.to_sym).evaluate(subject)
    end

    def evaluate_all(subject)
      return true if global_rules.any? { |rule| rule.evaluate(subject) }
      rules.values.any? { |rule| rule.evaluate(subject) }
    end

    private

    attr_reader :global_rules, :rules
  end
end
