Extension { #name : #JbIdentifierExpressionNode }

{ #category : #'*Jauburn-Interpreter' }
JbIdentifierExpressionNode >> evaluateIn: environment [ 

	^environment at: self identifier
]
