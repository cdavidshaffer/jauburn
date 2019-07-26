Class {
	#name : #JbParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbParserTest >> parserClass [

	^JbParser
]

{ #category : #tests }
JbParserTest >> testAssignmentStatement [

	| res |
	res := self parse: 'x = 33;y=-19;'.
	self assert: res first identifier equals: #x.
	self assert: res first expression value equals: 33.
	self assert: res second identifier equals: #y.
	self assert: res second expression value equals: -19.
	
	res := self parse: 'monkey = 3.14; zebra = -1232.112;'.
	self assert: res first identifier equals: #monkey.
	self assert: res first expression value equals: 3.14.
	self assert: res second identifier equals: #zebra.
	self assert: res second expression value equals: -1232.112.

]

{ #category : #running }
JbParserTest >> testEmptyFunctionDefinition [

	| function |
	function := self parse: 'function f() {}'.
	self assert: function notNil.
	self assert: function name equals: #f.
	
	function := self parse: 'function    z() {}'.
	self assert: function notNil.
	self assert: function name equals: #z.
	
	function := self parse: 'function monkey() {}'.
	self assert: function notNil.
	self assert: function name equals: #monkey.
	
	function := self parse: 'function 			
				zebra() {}'.
	self assert: function notNil.
	self assert: function name equals: #zebra.
]

{ #category : #tests }
JbParserTest >> testStatementSequence [

	self assert: (self parse: 'x = 33;')
		first identifier equals: #x.
	self assert: (self parse: 'x = 33;')
		first expression value equals: 33.

]
