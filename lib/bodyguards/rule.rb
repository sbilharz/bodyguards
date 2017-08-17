module Bodyguards
  class Rule
    def initialize(evaluator:)
      @evaluator = evaluator
    end

    def evaluate(subject)
      subject.instance_exec(&@evaluator)
    end
  end
end
