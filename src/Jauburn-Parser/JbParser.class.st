"
I am a parser for the Jauburn language.
"
Class {
	#name : #JbParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'function',
		'identifier',
		'functionSequence',
		'expression',
		'statementSequence',
		'statement',
		'assignmentStatement',
		'number',
		'constantExpression',
		'anonymousFunction',
		'variableDeclaration',
		'returnStatement',
		'ifStatement',
		'identifierExpression',
		'comparisonExpression'
	],
	#category : #'Jauburn-Parser'
}

{ #category : #functions }
JbParser >> anonymousFunction [

	^('function' asParser trim 
	, $( asParser trim , $) asParser trim
	, ${ asParser trim 
	, statement star
	, $} asParser trim) ==> 
					[:t | JbFunctionNode new name: nil; body: t fifth; yourself]
]

{ #category : #statements }
JbParser >> assignmentStatement [

	^(identifier trim , $= asParser trim , 
		expression)  ==> 
			[ :arr | JbAssignmentStatement new 
									identifier: arr first; 
									expression: arr third;
									yourself ]
]

{ #category : #expressions }
JbParser >> comparisonExpression [
	"placeholder!"
	
	^identifierExpression
	, '==' asParser trim 
	, number
]

{ #category : #expressions }
JbParser >> constantExpression [

	^number ==> [ :n | JbConstantExpression new value: n; yourself ]
]

{ #category : #expressions }
JbParser >> expression [ 

	^constantExpression / anonymousFunction / comparisonExpression / identifierExpression 

]

{ #category : #functions }
JbParser >> function [

	^('function' asParser trim 
	, identifier , $( asParser , $) asParser trim
	, ${ asParser trim 
	, statement star
	, $} asParser trim) ==> 
					[:t | JbFunctionNode new name: t second asSymbol; body: t sixth; yourself]
]

{ #category : #functions }
JbParser >> functionSequence [

	^function plus ==> [:t | t first ]
]

{ #category : #accessing }
JbParser >> identifier [ 

	^(#letter asParser , (#letter asParser / #digit asParser / 
			$_ asParser ) star) flatten trim
]

{ #category : #expressions }
JbParser >> identifierExpression [

	^identifier ==> [ :arr | JbIdentifierExpressionNode new identifier: arr; yourself ]
]

{ #category : #statements }
JbParser >> ifStatement [

	^'if' asParser trim
	, $( asParser trim
	, expression
	, $) asParser trim 
	, ${ asParser trim 
	, statementSequence
	, $} asParser trim ==>
		[ :arr |
			JbIfNode new
				condition: arr third;
				trueStatements: arr sixth;
				yourself ]
]

{ #category : #expressions }
JbParser >> number [ 

	^($- asParser optional, #digit asParser plus, $. asParser optional, #digit asParser star)
			 flatten trim ==> [ :str | str asNumber ]
]

{ #category : #statements }
JbParser >> returnStatement [

	^'return' asParser trim , expression ==> [ :arr |
			JbReturnStatementNode new
				expression: arr second;
				yourself ]
]

{ #category : #accessing }
JbParser >> start [ 

	^functionSequence / statementSequence
]

{ #category : #statements }
JbParser >> statement [

	^(assignmentStatement / variableDeclaration / returnStatement / ifStatement) trim
	, $; asParser 
		==> [ :arr | arr first ]
]

{ #category : #statements }
JbParser >> statementSequence [
	^ (statement trim , statementSequence trim star)
		==> [ :arr | arr flattened ]
]

{ #category : #statements }
JbParser >> variableDeclaration [

	^'var' asParser trim
	, identifier
	, $= asParser trim
	, expression ==> 
				[ :arr | JbVariableDeclarationNode new 
										identifier: arr second; 
										expression: arr fourth; 
										yourself ]
]
