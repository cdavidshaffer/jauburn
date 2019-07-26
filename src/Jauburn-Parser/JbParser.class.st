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
		'positiveNumber',
		'negativeNumber',
		'constantExpression'
	],
	#category : #'Jauburn-Parser'
}

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
JbParser >> constantExpression [

	^number ==> [ :n | JbConstantExpression new value: n; yourself ]
]

{ #category : #expressions }
JbParser >> expression [ 

	^constantExpression
]

{ #category : #functions }
JbParser >> function [

	^('function' asParser , #space asParser plus
	, identifier , $( asParser , $) asParser
	, #space asParser star
	, ${ asParser , $} asParser) ==> 
					[:t | JbFunctionNode new name: t third; yourself]
]

{ #category : #functions }
JbParser >> functionSequence [

	^function plus ==> [:t | t first ]
]

{ #category : #functions }
JbParser >> identifier [ 

	^(#letter asParser , (#letter asParser / #digit asParser / 
			$_ asParser ) star) flatten trim
]

{ #category : #expressions }
JbParser >> negativeNumber [ 

	^($- asParser , positiveNumber) flatten trim ==> [ :str | str asNumber ]
]

{ #category : #expressions }
JbParser >> number [ 

	^positiveNumber / negativeNumber 
]

{ #category : #expressions }
JbParser >> positiveNumber [ 

	^(#digit asParser plus, $. asParser optional, #digit asParser star)
			 flatten trim ==> [ :str | str asNumber ]
]

{ #category : #accessing }
JbParser >> start [
	"Answer the production to start this parser with."
	
	^functionSequence / statementSequence
]

{ #category : #statements }
JbParser >> statement [

	^(assignmentStatement trim, $; asParser) 
		==> [ :arr | arr first ]
]

{ #category : #statements }
JbParser >> statementSequence [
	^ (statement trim , statementSequence trim star)
		==> [ :arr | arr flattened ]
]

{ #category : #accessing }
JbParser >> whitespace [

	^#blank asParser / #newline asParser
]
