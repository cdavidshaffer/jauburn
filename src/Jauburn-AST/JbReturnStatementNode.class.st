Class {
	#name : #JbReturnStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbReturnStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbReturnStatementNode >> expression: anObject [
	expression := anObject
]
