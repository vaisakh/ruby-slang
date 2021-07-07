require_relative './lexer'
require_relative './token'
require_relative '../ast/meta/operator'
require_relative '../ast/expression/numeric_constant_expression'
require_relative '../ast/expression/unary_expression'


class RDParser < Lexer
  attr_reader :current_token

  def initialize(str)
    super(str)
  end

  def call_expression
    @current_token = get_token()
    Expr()
  end

  def Expr
    returnValue = Term()
    while @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()

      exp = Expr()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      returnValue = BinaryExpression.new(returnValue, exp, operator_token)
    end
    returnValue
  end

  def Term
    returnValue = Factor()
    while @current_token == Token::TOK_MULTIPLY || @current_token == Token::TOK_DIVIDE
      operator_token = @current_token
      @current_token = get_token()

      exp = Term()
      operator_token = operator_token == Token::TOK_MULTIPLY ? Operator::MULTIPLY : Operator::DIVIDE
      returnValue = BinaryExpression.new(returnValue, exp, operator_token)
    end
    returnValue
  end

  def Factor
    returnValue = nil
    if(@current_token == Token::TOK_NUMERIC)
      returnValue = NumericConstantExpression.new(get_number())
      @current_token = get_token()
    elsif @current_token == Token::TOK_OPEN_PAREN
      @current_token = get_token()
      returnValue = Expr()

      if(@current_token != Token::TOK_CLOSED_PAREN)
        raise Exception.new "Missing closing parenthesis"
      end
      @current_token = get_token()
    elsif @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()
      
      returnValue = Factor()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      returnValue = UnaryExpression.new(returnValue, operator_token)
      returnValue
    else
      raise Exception.new "Illegal token"
    end
    returnValue
  end
end