Extension { #name : #JbAssignmentStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbAssignmentStatementNode >> executeIn: environment [

	environment
		lookupAt: self identifier
		put: (self expression evaluateIn: environment)
]
