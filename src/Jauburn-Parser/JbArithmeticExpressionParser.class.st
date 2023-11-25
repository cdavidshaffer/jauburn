"
I parse arithmetic expressions
"
Class {
	#name : #JbArithmeticExpressionParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'arithmeticExpression',
		'numberExpression',
		'identifierExpression',
		'identifier',
		'arithmeticTerm',
		'arithmeticFactor'
	],
	#category : #'Jauburn-Parser-Core'
}

{ #category : #accessing }
JbArithmeticExpressionParser class >> dependencies [

	^ { JbNumberParser }
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticExpression [

	^ arithmeticTerm , ('+' asParser trim , arithmeticTerm) star
	  ==> [ :arr | 
		  | current |
		  current := arr first.
		  arr second do: [ :pair | 
			  current := JbAdditionNode new
				             lhs: current;
				             rhs: pair second;
				             yourself ].
		  current ]
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticFactor [

	^ '(' asParser trim , arithmeticExpression , ')' asParser trim
	  ==> [ :arr | arr second ] / numberExpression
	   / identifierExpression
]

{ #category : #'non-terminals' }
JbArithmeticExpressionParser >> arithmeticTerm [

	^ arithmeticFactor , ($* asParser trim , arithmeticFactor) star
	  ==> [ :arr | |current|
		current := arr first.
		arr second do: [ :pair |
		  current := JbMultiplicationNode new
			  lhs: current;
			  rhs: pair second
			  yourself].
		current ]
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
