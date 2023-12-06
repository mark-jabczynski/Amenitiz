# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Order do
  let(:orders) { create_list(:order, 3) }

  it { expect(described_class.by_uuid(orders[0..1].map(&:uuid))).to contain_exactly(*orders[0..1]) }
end
