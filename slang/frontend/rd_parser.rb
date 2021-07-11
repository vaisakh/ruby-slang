require_relative './lexer'
require_relative './token'
require_relative '../ast/meta/operator'
require_relative '../ast/expression/numeric_constant_expression'
require_relative '../ast/expression/unary_expression'
require_relative '../ast/expression/binary_expression'
require_relative '../ast/statements/printline_statement'
require_relative '../ast/statements/print_statement'


class RDParser < Lexer
  attr_reader :current_token

  def initialize(str)
    super(str)
  end

  def parse
    @current_token = get_token()
    get_statement_list()
  end

  # <stmtlist> := { <statement> }+
  def get_statement_list
    statements = []
    while(@current_token != Token::TOK_NULL)
      statement = parse_statement()
      if(statement != nil)
        statements.append(statement)
      end
    end
    statements
  end

  # <statement> := <printstmt> | <printlinestmt>
  def parse_statement
    statement = nil
    case @current_token
    when Token::TOK_PRINT
      statement = parse_print_statement()
      @current_token = get_token()
    when Token::TOK_PRINTLN
      statement = parse_print_line_statement()
      @current_token = get_token()
    else
      raise Exception.new "Invalid statement"
    end
    statement
  end

  # <printstmt> := print <expr>;
  def parse_print_statement
    @current_token = get_token()
    expression = parseExpression()
    if(@current_token != Token::TOK_SEMI)
      raise Exception.new "; expected"
    end
    PrintStatement.new(expression)
  end

  # <printlinestmt>:= printline <expr>;
  def parse_print_line_statement
    @current_token = get_token()
    expression = parseExpression()
    if(@current_token != Token::TOK_SEMI)
      raise Exception.new "; expected"
    end
    PrintlineStatement.new(expression)
  end

  def call_expression
    @current_token = get_token()
    parseExpression()
  end

  # <Expr> ::= <Term> | <Term> { + | - } <Expr>
  def parseExpression
    expression = parseTerm()
    while @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()

      exp = parseExpression()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      expression = BinaryExpression.new(expression, exp, operator_token)
    end
    expression
  end

  # <Term> ::= <Factor> | <Factor> {*|/} <Term>
  def parseTerm
    expression = parseFactor()
    while @current_token == Token::TOK_MULTIPLY || @current_token == Token::TOK_DIVIDE
      operator_token = @current_token
      @current_token = get_token()

      exp = parseTerm()
      operator_token = operator_token == Token::TOK_MULTIPLY ? Operator::MULTIPLY : Operator::DIVIDE
      expression = BinaryExpression.new(expression, exp, operator_token)
    end
    expression
  end

  # <Factor>::= <number> | ( <expr> ) | {+|-} <factor>
  def parseFactor
    expression = nil
    if(@current_token == Token::TOK_NUMERIC)
      expression = NumericConstantExpression.new(get_number())
      @current_token = get_token()
    elsif @current_token == Token::TOK_OPEN_PAREN
      @current_token = get_token()
      expression = parseExpression()

      if(@current_token != Token::TOK_CLOSED_PAREN)
        raise Exception.new "Missing closing parenthesis"
      end
      @current_token = get_token()
    elsif @current_token == Token::TOK_PLUS || @current_token == Token::TOK_MINUS
      operator_token = @current_token
      @current_token = get_token()

      expression = parseFactor()
      operator_token = operator_token == Token::TOK_PLUS ? Operator::PLUS : Operator::MINUS
      expression = UnaryExpression.new(expression, operator_token)
    else
      raise Exception.new "Illegal token"
    end
    expression
  end
end
