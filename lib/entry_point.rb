# frozen_string_literal: true

class EntryPoint
  class << self
    def call(...)
      new(...).call
    end
  end

  def call
    raise_validation_error if invalid_inputs?
    action.call
  end

  private

  attr_accessor :action, :inputs

  def invalid_inputs?
    inputs ? validation_result.failure? : false
  end

  def validation_result
    @validation_result ||= inputs.call
  end

  def raise_validation_error
    raise ::ValidationError, validation_result.errors(full: true).to_h
  end
end
