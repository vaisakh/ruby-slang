require_relative 'expression'
require_relative '../meta/operator'

class BinaryExpression < Expression
  attr_reader :l_expression, :r_expression, :operator

  def initialize(l_expression, r_expression, operator)
    @l_expression = l_expression
    @r_expression = r_expression
    @operator = operator
  end

  def evaluate(runtime_context)
    case @operator
    when Operator::PLUS then @l_expression.evaluate(runtime_context) + @r_expression.evaluate(runtime_context)
    when Operator::MINUS then @l_expression.evaluate(runtime_context) - @r_expression.evaluate(runtime_context)
    when Operator::DIVIDE then @l_expression.evaluate(runtime_context) / @r_expression.evaluate(runtime_context)
    when Operator::MULTIPLY then @l_expression.evaluate(runtime_context) * @r_expression.evaluate(runtime_context)
    end
  end
end
