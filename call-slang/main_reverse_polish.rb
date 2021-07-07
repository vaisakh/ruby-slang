require_relative '../slang/ast/expression/binary_expression'
require_relative '../slang/ast/expression/numeric_constant_expression'
require_relative '../slang/ast/meta/operator'
require_relative '../slang/ast/expression/unary_expression'
require_relative '../slang/builders/expression_builder'
require_relative '../slang/interpreter/reverse_polish_evaluator'

class Main
  def run
    b = ExpressionBuilder.new("-2*(3+3)+3+1")
    puts "-2*(3+3) +3+1"
    e = b.get_expression()

    e.accept(ReversePolishEvaluator.new);
  end
end

m = Main.new
m.run