Class {
	#name : #JbVariableDeclarationStatementNode,
	#superclass : #Object,
	#instVars : [
		'identifier',
		'expression'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbVariableDeclarationStatementNode >> expression [
	^ expression
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> expression: anObject [
	expression := anObject
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> identifier [
	^ identifier
]

{ #category : #accessing }
JbVariableDeclarationStatementNode >> identifier: anObject [
	identifier := anObject
]
