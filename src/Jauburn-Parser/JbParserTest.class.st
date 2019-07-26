Class {
	#name : #JbParserTest,
	#superclass : #TestCase,
	#instVars : [
		'parser'
	],
	#category : #'Jauburn-Parser'
}

{ #category : #running }
JbParserTest >> setUp [ 

	super setUp.
	parser := JbParser new.
]

{ #category : #running }
JbParserTest >> testFunctionDefinition [


]
