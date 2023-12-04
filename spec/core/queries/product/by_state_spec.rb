# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Queries::Product do
  it_behaves_like 'query with ByCode scope concern'
end
