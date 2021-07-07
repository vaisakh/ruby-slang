require_relative './t_stack'
require_relative '../ast/visitor/visitor'

class StackEvaluatorVisitor < Visitor
  attr_reader :stack

  def initialize
    @stack = TStack.new
  end

  def get_number
    @stack.pop()
  end

  def visit_NumericConstantExpression subject
    @stack.push(subject.value)
  end

  def visit_UnaryExpression subject
    value = subject.get_expression().accept(self)

    case subject.operator
    when Operator::PLUS then @stack.push(+value)
    when Operator::MINUS then @stack.push(-value)
    end
  end

  def visit_BinaryExpression subject
    operator = subject.get_operator()
    subject.get_left_expression().accept(self)
    subject.get_right_expression().accept(self)

    l_expression_value = @stack.pop()
    r_expression_value = @stack.pop()

    case operator
    when Operator::PLUS then @stack.push(l_expression_value + r_expression_value)
    when Operator::MINUS then @stack.push(l_expression_value - r_expression_value)
    when Operator::DIVIDE then @stack.push(l_expression_value / r_expression_value)
    when Operator::MULTIPLY then @stack.push(l_expression_value * r_expression_value)
    end
  end
end