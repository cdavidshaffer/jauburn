Extension { #name : #JbAbstractSyntaxTreeNode }

{ #category : #'*Jauburn-Interpreter' }
JbAbstractSyntaxTreeNode >> evaluateIn: aContext [

	self error:
		'Expressions must override this method.  Statements _must not_ override this method since it is an error to send #evaluateIn: to a statement.'
]

{ #category : #'*Jauburn-Interpreter' }
JbAbstractSyntaxTreeNode >> executeIn: aContext [

	self error: 'Statements must override this method.  Expressions _must not_ override this method since it is an error to send #executeIn: to an expression.'
]
