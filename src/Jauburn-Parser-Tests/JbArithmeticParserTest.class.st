Class {
	#name : #JbArithmeticParserTest,
	#superclass : #JbAbstractParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbArithmeticParserTest >> parserClass [

	^JbArithmeticExpressionParser 
]

{ #category : #tests }
JbArithmeticParserTest >> testArithmeticExpression [

	| expression |
	expression := self parse: '32' rule: #arithmeticExpression.
	self assertNode: expression value isConstant: 32.
	expression := self parse: '3+4' rule: #arithmeticExpression.
	self assertNode: expression lhs isConstant: 3.
	self assertNode: expression rhs isConstant: 4.
	self assertNode: expression isOperator: $+.
	expression := self parse: 'monkey*13' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'monkey'.
	self assertNode: expression rhs isConstant: 13.
	self assertNode: expression  isOperator: $*.
	expression := self parse: 'falafel' rule: #arithmeticExpression.
	self assertNode: expression isIdentifier: 'falafel'.
	expression := self parse: 'a * b * c' rule: #arithmeticExpression.
	self assertNode: expression lhs isIdentifier: 'a'.
	self assertNode: expression  isOperator: $*.
	expression := self parse: '-banana' rule: #arithmeticExpression.
	self assertNode: expression  isOperator: $-.
	self assert: expression operand identifier equals: 'banana'.
	expression := self parse: '3*-x' rule: #arithmeticExpression.
	self assertNode: expression rhs  isOperator: $-.
	self assertNode: expression rhs operand isIdentifier: 'x'.
	expression := self parse: '-x--y' rule: #arithmeticExpression.
	self assertNode: expression isOperator: $-.
	self assertNode: expression lhs isOperator: $-.
	self assertNode: expression rhs isOperator: $-.
	self assertNode: expression lhs operand isIdentifier: 'x'.
	self assertNode: expression rhs operand isIdentifier: 'y'.
	self fail: '-x---y' rule: #arithmeticExpression.
	self fail: '--x' rule: #arithmeticExpression
]

{ #category : #tests }
JbArithmeticParserTest >> testNumberExpression [

	"Numbers are tested in JbNumberParserTest.  Here we just make sure that the full parser can parse a number."

	self
		assertNode: (self parse: '15' rule: #numberExpression) 
		isConstant: 15.
	self fail: 'abc' rule: #numberExpression
]
