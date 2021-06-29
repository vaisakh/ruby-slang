
class Expression
	def evaluate(runtime_context)
		raise NoMethodError, "#{self.class} #evaluate method is abstract and must be implemented in the subclass"
	end
end