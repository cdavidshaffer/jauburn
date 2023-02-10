"
I parse arithmetic expressions
"
Class {
	#name : #JbArithmeticExpressionParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'arithmeticProduct',
		'arithmeticPrimitive',
		'arithmeticExpression',
		'numberExpression',
		'identifierExpression',
		'identifier'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #accessing }
JbArithmeticExpressionParser class >> dependencies [

	^ { JbNumberParser }
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticExpression [

	^ arithmeticProduct , '+' asParser trim , arithmeticExpression
	  ==> [ :arr | 
		  JbArity2OperatorNode new
			  lhs: arr first;
			  operator: $+;
			  rhs: arr third;
			  yourself ]
	   / arithmeticProduct
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticPrimitive [

	^ '(' asParser trim , arithmeticExpression , ')' asParser trim
	  ==> [ :arr | arr second ] / numberExpression
	  / ('-' asParser trim , identifierExpression ==> [ :arr | 
		   JbArity1OperatorNode new
			   operand: arr second;
			   operator: $-;
			   yourself ]) / identifierExpression
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticProduct [

	^ arithmeticPrimitive , $* asParser trim , arithmeticProduct
	  ==> [ :arr | 
		  JbArity2OperatorNode new
			  lhs: arr first;
			  operator: $*;
			  rhs: arr third;
			  yourself ]
	  / arithmeticPrimitive
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> identifier [

	^ (#letter asParser
	   , (#letter asParser / #digit asParser / $_ asParser) star) flatten
		  trim
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> identifierExpression [

	^ identifier ==> [ :arr | 
	  JbIdentifierExpressionNode new
		  identifier: arr;
		  yourself ]
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> numberExpression [

	^ (self dependencyAt: JbNumberParser) integer ==> [ :n | 
	  JbConstantExpressionNode new
		  value: n;
		  yourself ]
]

{ #category : #accessing }
JbArithmeticExpressionParser >> start [ 

	^arithmeticExpression 
]
