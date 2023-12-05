# frozen_string_literal: true

class Inputs < Dry::Validation::Contract
  config.messages.backend = :yaml
  config.messages.load_paths << File.join(Rails.root, 'config/locales/errors/inputs.yml')

  option :params

  def call
    super(params).tap do |result|
      self.attributes = result.values
    end
  end

  attr_reader :attributes

  private

  attr_writer :attributes
end
