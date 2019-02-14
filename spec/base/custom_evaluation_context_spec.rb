require_relative '../../lib/bodyguards/base'

RSpec.describe Bodyguards::Base do
  context 'when a subclass defines a custom permission_evaluation_context_class_name' do
    subject do
      Class.new(described_class) do
        self.permission_evaluation_context_class_name = 'MyCustomEvaluationContext'

        permit_to(:do_something) { cool_guy? }
      end
    end

    class MyCustomEvaluationContext
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def cool_guy?
        user.has_beer?
      end
    end

    context 'when a permission is queried' do
      subject do
        super().permission_to?(:do_something, user)
      end

      let(:user) { double(has_beer?: has_beer) }

      context 'when the permission evaluator returns truthy' do
        let(:has_beer) { true }

        it { is_expected.to eq(true) }
      end

      context 'when the permission evaluator returns falsey' do
        let(:has_beer) { false }

        it { is_expected.to eq(false) }
      end
    end
  end
end
