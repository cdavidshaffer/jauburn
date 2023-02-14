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
