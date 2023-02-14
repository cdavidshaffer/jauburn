Extension { #name : #JbPrintStatementNode }

{ #category : #'*Jauburn-Interpreter' }
JbPrintStatementNode >> executeIn: anEnvironment [

	| value |
	value := expression evaluateIn: anEnvironment.
	Transcript
		show: value;
		cr
]
