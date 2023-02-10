Class {
	#name : #JbAbstractParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #testing }
JbAbstractParserTest class >> isAbstract [

	"Override to true if a TestCase subclass is Abstract and should not have
	TestCase instances built from it"

	^ super isAbstract or: [self name = #JbAbstractParserTest]
]

{ #category : #utilities }
JbAbstractParserTest >> assertNode: aNode isConstant: constant [

	self assert: aNode value equals: constant
]

{ #category : #utilities }
JbAbstractParserTest >> assertNode: aNode isIdentifier: identifier [

	self assert: aNode identifier equals: identifier
]

{ #category : #utilities }
JbAbstractParserTest >> assertNode: aNode isOperator: operator [

	self assert: aNode operator equals: operator
]
