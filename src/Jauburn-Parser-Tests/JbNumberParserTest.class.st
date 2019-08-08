Class {
	#name : #JbNumberParserTest,
	#superclass : #PPCompositeParserTest,
	#category : #'Jauburn-Parser-Tests'
}

{ #category : #accessing }
JbNumberParserTest >> parserClass [ 

	^JbNumberParser 
]

{ #category : #tests }
JbNumberParserTest >> testCanParseDigit [

	self assert: (self parse: '5' rule: #digit) equals: $5.
	self assert: (self parse: '9' rule: #digit) equals: $9.
	self assert: (self parse: '0' rule: #digit) equals: $0.
	self fail: '-' rule: #digit.
	self fail: 'abc' rule: #digit
]

{ #category : #tests }
JbNumberParserTest >> testCanParseDigitNotZero [

	self assert: (self parse: '5' rule: #digitNotZero) equals: $5.
	self assert: (self parse: '9' rule: #digitNotZero) equals: $9.
	self fail: '-' rule: #digitNotZero.
	self fail: '0' rule: #digitNotZero.
	self fail: 'abc' rule: #digitNotZero
]

{ #category : #tests }
JbNumberParserTest >> testCanParseNegativeMultidigitInteger [

	self assert: '-3847' is: -3847.
	self assert: '-1273651' is: -1273651.

]

{ #category : #tests }
JbNumberParserTest >> testCanParseNegativeSingleDigitInteger [

	self assert: '-9' is: -9.

]

{ #category : #tests }
JbNumberParserTest >> testCanParsePositiveMultidigitInteger [

	self assert: '1233' is: 1233.
	self assert: '8347563' is: 8347563.

]

{ #category : #tests }
JbNumberParserTest >> testCanParsePositiveSingleDigitInteger [

	self assert: '3' is: 3.
	self assert: '0' is: 0.
	self assert: '9' is: 9
]

{ #category : #tests }
JbNumberParserTest >> testNotIntegers [

	self fail: '-' rule: #start.
	self fail: '0876' rule: #start.
	self fail: 'xqwdqw' rule: #start
]
