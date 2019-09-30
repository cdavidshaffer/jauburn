Extension { #name : #JbVariableDeclarationStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbVariableDeclarationStatementNode >> executeIn: environment [

	environment at: self identifier put: (self expression evaluateIn: environment)
]
