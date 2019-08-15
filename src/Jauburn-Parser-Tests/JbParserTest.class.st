Class {
	#name : #JbParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbParserTest >> parserClass [

	^JbParser
]

{ #category : #'tests-statements' }
JbParserTest >> testAnonymousFunctionDefinitionWithAssignment [
	| func |
	func := self parse: 'function () {x = 22;}' rule: #anonymousFunctionExpression.
	self assert: func name isNil.
	self assert: func body notEmpty.
	self assert: func body first identifier equals: 'x'
]

{ #category : #'tests-expressions' }
JbParserTest >> testAnonymousFunctionExpression [

	| f |
	f := self parse: 'function (x,y,z) { }' rule: #anonymousFunctionExpression.
	self assert: f name isNil.
	self assert: f body isEmpty.
	self assert: f parameters size equals: 3.
	f := self parse: 'function (a,b,something,nothing) { }' rule: #anonymousFunctionExpression.
	self assert: f name isNil.
	self assert: f body isEmpty.
	self assert: f parameters size equals: 4.
	self fail: 'function (x+1) { }' rule: #anonymousFunctionExpression.
]

{ #category : #'tests-expressions' }
JbParserTest >> testArithmeticExpression [

	| expression |
	expression := self parse: '32' rule: #arithmeticExpression.
	self assert: expression value equals: 32.
	expression := self parse: '3+4' rule: #arithmeticExpression.
	self assert: expression lhs value equals: 3.
	self assert: expression rhs value equals: 4.
	self assert: expression operator equals: $+.
	expression := self parse: 'monkey*13' rule: #arithmeticExpression.
	self assert: expression lhs identifier equals: 'monkey'.
	self assert: expression rhs value equals: 13.
	self assert: expression operator equals: $*.
	expression := self parse: 'falafel' rule: #arithmeticExpression.
	self assert: expression identifier equals: 'falafel'

]

{ #category : #'tests-statements' }
JbParserTest >> testAssignmentStatement [
	| exp |
	exp := self parse: 'x = 33;' rule: #assignmentStatement.
	self assert: exp identifier equals: 'x'.
	self assert: exp expression value equals: 33
]

{ #category : #'tests-expressions' }
JbParserTest >> testComparisonExpression [

	| exp |
	exp := self parse: 'falafel==1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '=='.
	exp := self parse: 'falafel<1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '<'.
	exp := self parse: 'falafel<=1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '<='.
	exp := self parse: 'falafel>1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '>'.
	exp := self parse: 'falafel>=1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '>='.
	exp := self parse: 'falafel!=1' rule: #comparisonExpression.
	self assert: exp lhs identifier equals: #falafel.
	self assert: exp operator equals: '!='.

]

{ #category : #'tests-expressions' }
JbParserTest >> testExpression [ 

	| exp |
	exp := self parse: '3+4' rule: #expression.
	self assert: exp lhs value equals: 3.
	exp := self parse: 'function (a,b,something,nothing) { }' rule: #expression.
	self assert: exp parameters size equals: 4.
	exp := self parse: 'x == 1' rule: #expression.
	self assert: exp operator equals: '=='
]

{ #category : #'tests-expressions' }
JbParserTest >> testExpressionList [

	| vals |
	vals := self parse: '1,23,monkey,18+2*5' rule: #expressionList.
	self assert: vals first value equals: 1.
	self assert: vals second value equals: 23.
	self assert: vals third identifier equals: 'monkey'.
	self assert: vals fourth operator equals: $+.
]

{ #category : #'tests-expressions' }
JbParserTest >> testFunctionCallExpression [

	| call |
	call := self parse: 'f(a,b+c,c)' rule: #functionCallExpression.
	self assert: call identifier equals: 'f'.
	self assert: call arguments first identifier equals: 'a'.
	self assert: call arguments second operator equals: $+.
	self assert: call arguments third identifier equals: 'c'.
	
	call := self parse: 'speak()' rule: #functionCallExpression.
	self assert: call identifier equals: 'speak'.
	self assert: call arguments isEmpty.
]

{ #category : #'tests-expressions' }
JbParserTest >> testIdentifierExpression [

	self assert: (self parse: 's1mpl3' rule: #identifierExpression) identifier equals: 's1mpl3'.
	self assert: (self parse: 'a___11bADWQ' rule: #identifierExpression) identifier equals: 'a___11bADWQ'.
	self fail: 'a?' rule: #identifierExpression.
	self fail: '12monkeys' rule: #identifierExpression
]

{ #category : #'tests-expressions' }
JbParserTest >> testIdentifierExpressionList [

	self assert: (self parse: 'apple,banana,monkey' rule: #identifierExpressionList) size equals: 3.
	self assert: (self parse: '' rule: #identifierExpressionList) size equals: 0
]

{ #category : #'tests-statements' }
JbParserTest >> testIfElseStatement [

	| stmt |
	stmt := self parse: 'if (x+99 < 1) {} else {}' rule: #ifElseStatement.
	self assert: stmt condition operator equals: '<'.
	self assert: stmt trueStatements isEmpty.
	self assert: stmt falseStatements isEmpty
]

{ #category : #'tests-statements' }
JbParserTest >> testIfStatement [

	| stmt |
	stmt := self parse: 'if (x == 1) {}' rule: #ifStatement.
	self assert: stmt condition operator equals: '=='.
	self assert: stmt trueStatements isEmpty
]

{ #category : #'tests-expressions' }
JbParserTest >> testNumberExpression [
	"Numbers are tested in JbNumberParserTest.  Here we just make sure that
	we can parse a number."
	
	self assert: (self parse: '15' rule: #numberExpression) value equals: 15.
	self fail: 'abc' rule: #numberExpression
]

{ #category : #'tests-program' }
JbParserTest >> testProgram [ 

	| pgm |
	pgm := self parse: 'var x = function(x) { var z = 22; var y = z + 1; };
var lmnop123 = 9 * 2 + 44;'.
	self assert: pgm statements size equals: 2.
	self assert: pgm statements first identifier equals: 'x'.
	self assert: pgm statements second identifier equals: 'lmnop123'
]

{ #category : #'tests-statements' }
JbParserTest >> testReturnStatement [
	| func |
	func := self parse: 'return 37' rule: #returnStatement.
	self assert: func expression value equals: 37
]

{ #category : #'tests-statements' }
JbParserTest >> testStatement [ 

	| stmt |
	stmt := self parse: 'var monkey = -1231 + x;' rule: #statement.
	self assert: stmt identifier equals: 'monkey'.
	stmt := self parse: 'zebra = 3 *x - 1;' rule: #statement.
	self assert: stmt identifier equals: 'zebra'.
	stmt := self parse: 'if (x == 2) {} else {}' rule: #statement.
	self assert: stmt condition operator equals: '=='.
	stmt := self parse: 'if (zebra > 12) {}' rule: #statement.
	self assert: stmt condition operator equals: '>'.
	self assert: stmt condition lhs identifier equals: 'zebra'
]

{ #category : #'tests-statements' }
JbParserTest >> testStatementBlock [ 

	| blk |
	blk := self parse: '{ x = 1; var y = 23 * x; }' rule: #statementBlock.
	self assert: blk size equals: 2.
	self assert: blk first identifier equals: 'x'.
	self assert: blk second identifier equals: 'y'
]

{ #category : #'tests-statements' }
JbParserTest >> testVariableDeclarationStatement [

	| stmt |
	stmt := self parse: 'var x = 22;' rule: #variableDeclarationStatement.
	self assert: stmt identifier equals: 'x'.
	stmt := self parse: 'var monkey = 37*x;' rule: #variableDeclarationStatement.
	self assert: stmt identifier equals: 'monkey'
]
