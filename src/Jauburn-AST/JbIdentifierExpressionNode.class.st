Class {
	#name : #JbIdentifierExpressionNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'identifier'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbIdentifierExpressionNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbIdentifierExpressionNode >> identifier: anObject [
	identifier := anObject
]
