"
Numeric comparison.  Note: unlike numeric operations, comparisons are all instances of this class but with different values for the operator.  There are no separate subclasses for equality, less than or equal to and so on.  Honestly, this approach could have been used in arithmetic as well but I didn't want to change it post-lecture video.
"
Class {
	#name : #JbNumericComparisonNode,
	#superclass : #JbArity2OperatorNode,
	#instVars : [
		'operator'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbNumericComparisonNode >> operator [

	^ operator
]

{ #category : #accessing }
JbNumericComparisonNode >> operator: anObject [

	operator := anObject
]
