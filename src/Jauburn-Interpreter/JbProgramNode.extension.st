Extension { #name : #JbProgramNode }

{ #category : #'*Jauburn-Interpreter' }
JbProgramNode >> executeIn: environment [

	statements do: [ :each | each executeIn: environment ]
]
