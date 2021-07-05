require_relative '../slang/ast/expression/binary_expression'
require_relative '../slang/ast/expression/numeric_constant_expression'
require_relative '../slang/ast/meta/operator'
require_relative '../slang/ast/expression/unary_expression'
require_relative '../slang/builders/expression_builder'
require_relative '../slang/interpreter/tree_evaluator_visitor'

class Main
  def run
    b = ExpressionBuilder.new("-2*(3+3) +3+1")
    e = b.get_expression()
    x = e.accept(TreeEvaluatorVisitor.new)
    puts x
  end
end

m = Main.new
m.run