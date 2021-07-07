require_relative '../slang/ast/expression/binary_expression'
require_relative '../slang/ast/expression/numeric_constant_expression'
require_relative '../slang/ast/meta/operator'
require_relative '../slang/ast/expression/unary_expression'
require_relative '../slang/builders/expression_builder'
require_relative '../slang/interpreter/stack_evaluator_visitor'

class Main
  def run
    b = ExpressionBuilder.new("2+1+3+(3*5)")
    # b = ExpressionBuilder.new("-2*(3+3)+3+1")
    e = b.get_expression()
    s = StackEvaluatorVisitor.new;
    e.accept(s);
    puts s.get_number();
  end
end

m = Main.new
m.run