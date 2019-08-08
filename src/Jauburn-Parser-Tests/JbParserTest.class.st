Class {
	#name : #JbParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbParserTest >> parserClass [

	^JbParser
]

{ #category : #tests }
JbParserTest >> testAnonymousFunctionDefinitionWithAssignment [
	| func |
	func := self parse: 'function () {x = 22;}' rule: #anonymousFunction.
	self assert: func name isNil.
	self assert: func body notEmpty.
	self assert: func body first identifier equals: #x
]

{ #category : #'tests-expressions' }
JbParserTest >> testArithmeticExpression [

	| expression |
	expression := self parse: '3+4' rule: #arithmeticExpression.
	self assert: expression lhs value equals: 3.
	self assert: expression rhs value equals: 4.
	self assert: expression operator equals: $+.
	expression := self parse: 'monkey*13' rule: #arithmeticExpression.
	self assert: expression lhs identifier equals: 'monkey'.
	self assert: expression rhs value equals: 13.
	self assert: expression operator equals: $*

]

{ #category : #tests }
JbParserTest >> testAssignmentStatement [

	self assert: (self parse: 'x = 33;')
		first identifier equals: #x.
	self assert: (self parse: 'x = 33;')
		first expression value equals: 33.

]

{ #category : #tests }
JbParserTest >> testAssignmentStatementSequence [

	| res |
	res := self parse: 'x = 33;y=-19;'.
	self assert: res first identifier equals: #x.
	self assert: res first expression value equals: 33.
	self assert: res second identifier equals: #y.
	self assert: res second expression value equals: -19.
	
	res := self parse: 'monkey = 3.14; zebra = -1232.112;'.
	self assert: res first identifier equals: #monkey.
	self assert: res first expression value equals: 3.14.
	self assert: res second identifier equals: #zebra.
	self assert: res second expression value equals: -1232.112.

]

{ #category : #'tests-expressions' }
JbParserTest >> testComparisonExpression [

	| exp |
	exp := self parse: 'falaffel == 1' rule: #expression.
	self assert: exp first identifier equals: #falaffel
]

{ #category : #tests }
JbParserTest >> testEmptyFunctionDefinition [

	| function |
	function := self parse: 'function f() {}'.
	self assert: function notNil.
	self assert: function name equals: #f.
	
	function := self parse: 'function    z() {}'.
	self assert: function notNil.
	self assert: function name equals: #z.
	
	function := self parse: 'function monkey() {}'.
	self assert: function notNil.
	self assert: function name equals: #monkey.
	
	function := self parse: 'function 			
				zebra() {}'.
	self assert: function notNil.
	self assert: function name equals: #zebra.
]

{ #category : #tests }
JbParserTest >> testFunctionDefinitionWithAssignment [
	| function |
	function := self parse: 'function f() {x = 22;}'.
	self assert: function notNil.
	self assert: function name equals: #f.
	self assert: function body first identifier equals: #x.
	self assert: function body first expression value equals: 22
]

{ #category : #tests }
JbParserTest >> testIfStatement [

	| stmt |
	stmt := self parse: 'if (x == 1) {y = 2;}' rule: #ifStatement.
	self assert: (stmt isKindOf: JbIfNode)
]

{ #category : #'tests-expressions' }
JbParserTest >> testNumberExpression [
	"Numbers are tested in JbNumberParserTest.  Here we just make sure that
	we can parse a number."
	
	self assert: (self parse: '15' rule: #numberExpression) value equals: 15.
	self fail: 'abc' rule: #numberExpression
]

{ #category : #tests }
JbParserTest >> testReturnStatement [
	| func |
	func := self parse: 'return 37' rule: #returnStatement.
	self assert: func expression value equals: 37
]

{ #category : #tests }
JbParserTest >> testVariableDeclaration [

	| d |
	d := self parse: 'var x = 0' rule: #variableDeclaration.
	self assert: d identifier equals: #x.
	self assert: d expression value equals: 0
]
