Class {
	#name : #JbPrintStatementNode,
	#superclass : #JbAbstractSyntaxTreeNode,
	#instVars : [
		'expression'
	],
	#category : #'Jauburn-AST'
}

{ #category : #accessing }
JbPrintStatementNode >> expression [

	^ expression
]

{ #category : #accessing }
JbPrintStatementNode >> expression: anObject [

	expression := anObject
]
