Extension { #name : #JbNumericComparisonNode }

{ #category : #'*Jauburn-Interpreter' }
JbNumericComparisonNode >> evaluateIn: environment [

	| lhsValue rhsValue |
	lhsValue := self lhs evaluateIn: environment.
	rhsValue := self rhs evaluateIn: environment.

	self operator = '<' ifTrue: [ ^ lhsValue < rhsValue ].
	self operator = '>' ifTrue: [ ^ lhsValue > rhsValue ].
	self operator = '<=' ifTrue: [ ^ lhsValue <= rhsValue ].
	self operator = '>=' ifTrue: [ ^ lhsValue >= rhsValue ].
	self operator = '==' ifTrue: [ ^ lhsValue = rhsValue ].
	self operator = '!=' ifTrue: [ ^ lhsValue ~= rhsValue ].


	self error: 'Unrecognized operator: ' , self operator asString
]
