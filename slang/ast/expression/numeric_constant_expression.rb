require_relative 'expression'

class NumericConstantExpression < Expression
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def evaluate(runtime_context)
    @value
  end
end