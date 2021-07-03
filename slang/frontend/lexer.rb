require_relative './token'

class Lexer
	attr_reader	:expression
	attr_reader	:cursor
	attr_reader	:length
	attr_reader	:number

	def initialize(expression)
		@expression = expression
		@length = expression.length
		@cursor = 0
	end

	def get_token
		token = Token::ILLEGAL_TOKEN

		# Skip white space
		while @cursor < @length && @expression[@cursor] == ' ' || @expression[@cursor] == '\t' do
			@cursor += 1
		end

		# End of string? return null
		if @cursor == @length
			return Token::TOK_NULL
		end

		case @expression[@cursor]
		when '+'
			token = Token::TOK_PLUS
			@cursor +=1
		when '-'
			token = Token::TOK_MINUS
			@cursor +=1
		when '/'
			token = Token::TOK_DIVIDE
			@cursor +=1
		when '*'
			token = Token::TOK_MULTIPLY
			@cursor +=1
		when '('
			token = Token::TOK_OPEN_PAREN
			@cursor +=1
		when ')'
			token = Token::TOK_CLOSED_PAREN
			@cursor +=1
		when '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'
			str = ""
			while @cursor < @length && 
				@expression[@cursor] == '0' || @expression[@cursor] == '1' ||
				@expression[@cursor] == '2' || @expression[@cursor] == '3' ||
				@expression[@cursor] == '4' || @expression[@cursor] == '5' ||
				@expression[@cursor] == '6' || @expression[@cursor] == '7' ||
				@expression[@cursor] == '8' || @expression[@cursor] == '9' do
				
				str += @expression[@cursor]
				@cursor += 1 
			end

			@number = str.to_i
			token = Token::TOK_DOUBLE
		else
			raise Exception.new "Error while analyzing tokens"
		end
		return token
	end

	def get_number
		@number
	end
end