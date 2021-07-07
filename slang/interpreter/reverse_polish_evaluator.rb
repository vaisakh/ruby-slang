require_relative '../ast/visitor/visitor'

class ReversePolishEvaluator < Visitor
  def visit_NumericConstantExpression subject
    print "#{subject.value} "
  end

  def visit_UnaryExpression subject
    case subject.operator
    when Operator::PLUS then print " + "
    when Operator::MINUS then print " (-) #{subject.get_expression().accept(self)}"
    end
  end

  def visit_BinaryExpression subject
    operator = subject.get_operator()
    l_expression_value = subject.get_left_expression().accept(self)
    r_expression_value = subject.get_right_expression().accept(self)

    case operator
    when Operator::PLUS then print " + "
    when Operator::MINUS then print " - "
    when Operator::DIVIDE then print " / "
    when Operator::MULTIPLY then print " * "
    end
  end
end