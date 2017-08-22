module Bodyguards
  class RuleSet
    def initialize
      @rules = {}
    end

    def add_rule_for(feature_name, rule)
      rules[feature_name.to_sym] = rule
    end

    def evaluate(feature_name, subject)
      rules.fetch(feature_name.to_sym).evaluate(subject)
    end

    def evaluate_all(subject)
      rules.values.any? { |rule| rule.evaluate(subject) }
    end

    private

    attr_reader :rules
  end
end
