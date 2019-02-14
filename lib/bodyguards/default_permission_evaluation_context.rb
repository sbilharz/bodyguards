require 'active_support/core_ext/module/delegation'

module Bodyguards
  class DefaultPermissionEvaluationContext
    attr_reader :subject

    delegate_missing_to :subject

    def initialize(subject)
      @subject = subject
    end
  end
end
