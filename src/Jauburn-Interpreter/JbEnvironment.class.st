"
This is a copy of the Phsyche PEnvironment class
"
Class {
	#name : #JbEnvironment,
	#superclass : #Object,
	#instVars : [
		'bindings',
		'outerEnvironment'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #accessing }
JbEnvironment >> at: aKey [

	| value |
	value := bindings at: aKey ifAbsent: [ nil ].
	^ value
		  ifNil: [ 
			  outerEnvironment
				  ifNil: [ bindings at: aKey ]
				  ifNotNil: [ outerEnvironment at: aKey ] ]
		  ifNotNil: [ :v | v ]
]

{ #category : #accessing }
JbEnvironment >> at: aKey put: aValue [

	bindings at: aKey put: aValue
]

{ #category : #accessing }
JbEnvironment >> includesKey: aKey [

	^bindings includesKey: aKey
]

{ #category : #accessing }
JbEnvironment >> initialize [ 

	super initialize .
	bindings := Dictionary new.
]

{ #category : #accessing }
JbEnvironment >> lookupAt: aKey put: aValue [

	"Change the value of the binding whose key is aKey, but looking in the complete ancestor chain.
	If the binding does not exist, it raises an error to indicate that we should define it first."

	| found |
	found := bindings at: aKey ifAbsent: nil.
	found
		ifNil: [ 
			outerEnvironment
				ifNotNil: [ outerEnvironment lookupAt: aKey put: aValue ]
				ifNil: [ 
				KeyNotFound signal: aKey , ' not found in the environment' ] ]
		ifNotNil: [ self at: aKey put: aValue ]
]

{ #category : #accessing }
JbEnvironment >> outerEnvironment: anEnvironment [
	outerEnvironment := anEnvironment
]

{ #category : #accessing }
JbEnvironment >> variableNames [

	^ bindings keys
]
