require_relative '../../lib/bodyguards/base'

RSpec.describe Bodyguards::Base do
  context 'when a subclass defines a permission' do
    subject do
      Class.new(described_class) do
        permit_to(:do_something) { basic_rights? }
      end
    end

    let(:user) { double(basic_rights?: basic_rights) }

    context 'when the permission is queried' do
      subject do
        super().permission_to?(:do_something, user)
      end

      context 'when the permission evaluator returns truthy' do
        let(:basic_rights) { true }

        it { is_expected.to eq(true) }
      end

      context 'when the permission evaluator returns falsey' do
        let(:basic_rights) { false }

        it { is_expected.to eq(false) }
      end
    end

    context 'when the rejection is queried' do
      subject do
        super().rejection_to?(:do_something, user)
      end

      context 'when the permission evaluator returns truthy' do
        let(:basic_rights) { true }

        it { is_expected.to eq(false) }
      end

      context 'when the permission evaluator returns falsey' do
        let(:basic_rights) { false }

        it { is_expected.to eq(true) }
      end
    end
  end
end
