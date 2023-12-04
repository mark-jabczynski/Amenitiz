# frozen_string_literal: true

RSpec.shared_examples 'query with ByCode scope concern' do
  context 'with ByCode concern within Scopes module' do
    subject { described_class::Scopes.included_modules }

    it { is_expected.to include(Queries::Concerns::ByCode) }
  end
end
