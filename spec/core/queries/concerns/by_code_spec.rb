# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Concerns::ByCode do
  let(:object) { klass.new }
  let(:klass) { Class.new(double.class) { include Queries::Concerns::ByCode } }

  let(:code) { 'code' }

  describe '#by_code' do
    subject { object.by_code(code) }

    it 'calls AR where clause with params' do
      expect(object).to receive(:where).with(code: code)
      subject
    end
  end
end
