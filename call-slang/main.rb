require_relative '../slang/ast/expression/binary_expression'
require_relative '../slang/ast/expression/numeric_constant_expression'
require_relative '../slang/ast/meta/operator'
require_relative '../slang/ast/expression/unary_expression'

class Main
  def run
    expression = BinaryExpression.new(
      NumericConstantExpression.new(5),
      NumericConstantExpression.new(10),
      Operator::PLUS)
    puts expression.evaluate(nil )

    expression2 = UnaryExpression.new(
      BinaryExpression.new(NumericConstantExpression.new(10),
        BinaryExpression.new(NumericConstantExpression.new(30), 
          NumericConstantExpression.new(50), 
          Operator::PLUS),
        Operator::PLUS),
      Operator::MINUS)
    puts expression2.evaluate(nil)
  end
end

m = Main.new
m.run