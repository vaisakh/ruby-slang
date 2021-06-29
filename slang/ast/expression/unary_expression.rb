require_relative 'expression'
require_relative '../meta/operator'

class UnaryExpression < Expression
  attr_accessor :expression, :operator

  def initialize(exp, op)
    @expression = exp
    @operator = op
  end

  def evaluate(runtime_context)
    case @operator
    when Operator::PLUS then @expression.evaluate(runtime_context)
    when Operator::MINUS then - @expression.evaluate(runtime_context)
    end
  end
end
